# OpenCode Docker 映像檔

![GitHub Actions Workflow Status](https://github.com/chihualu/opencode/actions/workflows/publish.yml/badge.svg)
![License](https://img.shields.io/github/license/chihualu/opencode)

本專案提供了一個客製化的 **OpenCode** Docker 映像檔，延伸自官方的 `ghcr.io/anomalyco/opencode`。它預先配置了 `opencode.json`，方便您直接連接支援 OpenAI 協定的 API 服務（例如 vLLM）。

## 功能特色

*   **基底映像檔**: 建構於 `ghcr.io/anomalyco/opencode:latest` 之上。
*   **預先配置**: 將 `opencode.json` 內建於 `/etc/opencode/` 目錄中。
*   **環境變數支援**: 可透過 `API_BASEURL` 和 `API_KEY` 環境變數彈性設定連線資訊。

## 快速開始

### 事前準備

*   您的機器上已安裝 Docker。
*   擁有一個相容 OpenAI 協定的 API 端點（例如 vLLM, Ollama 等）。

### 使用說明

您可以直接從 GitHub Container Registry 下載已建置好的映像檔：

```bash
docker pull ghcr.io/chihualu/opencode:latest
```

### 啟動容器 (Server 模式)

使用以下指令以背景服務方式 (`-d`) 啟動容器，並命名為 `opencode`：

```bash
docker run --name opencode -d \
  -p 3000:3000 \
  -e API_BASEURL="https://your-api-endpoint.com/v1" \
  -e API_KEY="your-secret-api-key" \
  ghcr.io/chihualu/opencode:latest
```

**參數說明：**

*   **`--name opencode`**: 將容器命名為 `opencode`，方便後續管理。
*   **`-d`**: 在背景執行容器 (Detached mode)。
*   **`-p 3000:3000`**: 將容器的 3000 Port 對應到主機的 3000 Port。
*   **`-e API_BASEURL`**: 您的 LLM 服務網址 (Base URL)。
*   **`-e API_KEY`**: 您的 API 金鑰。

## 設定檔說明

此映像檔使用位於 `/etc/opencode/opencode.json` 的設定檔。
系統已透過 `OPENCODE_CONFIG` 環境變數指定此路徑，啟動時會自動載入。

### 預設 Provider 設定
*   **Provider**: `vllm` (透過 `@ai-sdk/openai-compatible`)
*   **Default Model**: `gpt-oss`

## 授權條款 (License)

本專案採用 MIT License 授權 - 詳細內容請參閱 [LICENSE](LICENSE) 檔案。