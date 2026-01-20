# ProCode Docker 映像檔

![GitHub Actions Workflow Status](https://github.com/chihualu/procode/actions/workflows/publish.yml/badge.svg)
![License](https://img.shields.io/github/license/chihualu/procode)

本專案提供了一個 Docker 化的 **[LLxprt Code](https://github.com/vybestack/llxprt-code)** 環境，並命名為 **ProCode**。

## 功能特色

*   **核心**: 基於 Node.js 20 與 `@vybestack/llxprt-code`。
*   **彈性**: 支援透過環境變數設定 API Base URL 和 API Key。
*   **輕量**: 使用 `node:20-slim` 作為基底。
*   **預設配置**: 內建 Provision 設定檔。

## 快速開始

### 啟動容器

您可以使用以下指令來啟動容器並進入互動模式：

```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -e API_BASEURL="https://ai.provision.com.tw/v1" \
  -e API_KEY="your-secret-api-key" \
  ghcr.io/chihualu/procode:latest
```

**參數說明：**

*   **`-v $(pwd):/workspace`**: 將目前目錄掛載到容器內。
*   **`-e API_BASEURL`**: 您的 API 網址。
*   **`-e API_KEY`**: 您的 API 金鑰 (會自動注入設定檔)。

### 進階指令

您也可以直接傳遞參數給 `llxprt`：

```bash
docker run -it --rm ghcr.io/chihualu/procode:latest --help
```

## 授權條款 (License)

本專案採用 Apache License 2.0 授權 - 詳細內容請參閱 [LICENSE](LICENSE) 檔案。
