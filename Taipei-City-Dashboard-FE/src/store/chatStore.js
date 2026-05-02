import { ref, watch } from "vue";
import { defineStore } from "pinia";
import http from "../router/axios";

const recommendChatStorageKey = "recommendChatData";
const aiChatStorageKey = "aiChatData";

const defaultRecommendChatData = [
	{
		id: 1,
		role: "bot",
		isDefault: true,
		content:
			"您好，我是【臺北城市儀表板】小幫手，很高興為您服務！\n 您可以： \n\n • 點擊左側既有的儀表板主題，快速查看各主題內容 \n • 輸入您感興趣的主題描述，我會自動為您組建最適合的儀表板 \n\n 如果有想了解的內容，歡迎直接告訴我，我會盡力協助！\n\n 📩 聯絡信箱：tuic@gov.taipei \n 🏢 臺北大數據中心 \n\n",
	},
];

const defaultAiChatData = [
	{
		id: 1,
		role: "bot",
		isDefault: true,
		content:
			"您好，我是【臺北城市儀表板】AI 對話助手。您可以直接詢問一般問題，我會盡力協助。",
	},
];

function readStoredChatData(storageKey) {
	try {
		return JSON.parse(sessionStorage.getItem(storageKey)) || [];
	} catch (error) {
		console.error("readStoredChatData error:", error);
		return [];
	}
}

function persistChatData(storageKey, chatData) {
	const userBotMessages = chatData.filter((item) => !item.isDefault);
	sessionStorage.setItem(storageKey, JSON.stringify(userBotMessages));
}

function appendMessage(targetChatData, newChatData) {
	targetChatData.value.push({
		id: targetChatData.value.length + 1,
		isDefault: false,
		...newChatData,
	});
}

function dedupeRecommendedComponents(components) {
	return Array.from(
		components
			.reduce((map, item) => {
				const key = item.index;
				const exist = map.get(key);

				if (!exist || item.city === "metrotaipei") {
					map.set(key, item);
				}

				return map;
			}, new Map())
			.values()
	);
}

export const useChatStore = defineStore("chat", () => {
	const recommendComponents = ref(null);
	const isAiLoading = ref(false);
	const recommendChatData = ref([
		...defaultRecommendChatData,
		...readStoredChatData(recommendChatStorageKey),
	]);
	const aiChatData = ref([
		...defaultAiChatData,
		...readStoredChatData(aiChatStorageKey),
	]);

	watch(
		recommendChatData,
		(newVal) => {
			persistChatData(recommendChatStorageKey, newVal);
		},
		{ deep: true }
	);

	watch(
		aiChatData,
		(newVal) => {
			persistChatData(aiChatStorageKey, newVal);
		},
		{ deep: true }
	);

	const appendRecommendChatData = (newChatData) => {
		appendMessage(recommendChatData, newChatData);
	};

	const appendAiChatData = (newChatData) => {
		appendMessage(aiChatData, newChatData);
	};

	const clearAiChatData = () => {
		aiChatData.value = [...defaultAiChatData];
	};

	const addChatData = (newChatData) => {
		appendRecommendChatData(newChatData);
	};

	const addQueryData = async (newChatData) => {
		appendRecommendChatData(newChatData);

		recommendComponents.value = [];

		try {
			const response = await http.post(
				"/vector/component",
				new URLSearchParams({
					query: newChatData.content,
					limit: 10,
					score: 0.8,
				}),
				{
					headers: {
						"Content-Type": "application/x-www-form-urlencoded",
					},
				}
			);
			if (response.data?.data?.length > 0) {
				recommendComponents.value = response.data.data;
			}

			recommendComponents.value = dedupeRecommendedComponents(
				recommendComponents.value
			);
		} catch (error) {
			console.error("VectorAnalysisError :", error);
		}

		if (recommendComponents.value.length > 0) {
			const topK = [...recommendComponents.value].sort(
				(a, b) => b.score - a.score
			);
			appendRecommendChatData({
				role: "bot",
				button: [{ id: 1, text: "建立儀表板" }],
				content:
					"您好 😊 \n 以下是根據您的問題，自動為您推薦的「組件清單」。您可以將這些組件整批加入「個人儀表板」，方便日後快速查看與使用。\n",
				relations: topK,
			});
			appendRecommendChatData({
				role: "bot",
				content:
					"若您有任何新的查詢或想深入探索的內容，都可以隨時在對話框告訴我～\n 我很樂意再協助您 💬✨",
			});
		} else {
			appendRecommendChatData({
				role: "bot",
				content: "很抱歉，您提供的描述沒有相似組件，請繼續提問 ! ",
			});
		}

		saveChatLog(newChatData.content, recommendComponents.value);
	};

	const getDailySessionId = () => {
		const d = new Date();
		return (
			"session_" +
			d.getFullYear() +
			String(d.getMonth() + 1).padStart(2, "0") +
			String(d.getDate()).padStart(2, "0")
		);
	};

	const addAiChatData = async (newChatData) => {
		if (isAiLoading.value) return;

		appendAiChatData(newChatData);

		isAiLoading.value = true;

		try {
			const response = await http.post("/ai/chat/twai", {
				session: getDailySessionId(),
				stream: false,
				messages: [
					{
						role: "user",
						content: newChatData.content,
					},
				],
			});

			const answer = response.data?.data?.content;
			appendAiChatData({
				role: "bot",
				content: answer || "AI 目前沒有回覆內容，請稍後再試。",
			});
		} catch (error) {
			console.error("AIChatError :", error);
			appendAiChatData({
				role: "bot",
				content: getAiErrorMessage(error),
			});
		} finally {
			isAiLoading.value = false;
		}
	};

	const getAiErrorMessage = (error) => {
		const status = error.response?.status;
		if (status === 401 || status === 403) {
			return "請先登入會員以使用 AI 對話功能。";
		}
		return "AI 對話服務暫時無法回應，請稍後再試。";
	};

	const saveChatLog = async (question, answer) => {
		try {
			const formData = new FormData();
			formData.append("session", getDailySessionId());
			formData.append("question", question);
			formData.append("answer", JSON.stringify(answer));

			await http.post("/chatlog/", formData, {
				headers: {
					"Content-Type": "multipart/form-data",
				},
			});
		} catch (error) {
			console.error("saveChatLog error:", error);
		}
	};

	return {
		recommendChatData,
		aiChatData,
		isAiLoading,
		addChatData,
		addQueryData,
		addAiChatData,
		clearAiChatData,
		saveChatLog,
	};
});
