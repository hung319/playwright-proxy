FROM python:3.10-slim

# Cài gói hệ thống cần thiết cho trình duyệt Chromium
RUN apt-get update && apt-get install -y \
    wget gnupg curl unzip fonts-liberation libasound2 libatk1.0-0 \
    libcups2 libdbus-1-3 libgdk-pixbuf2.0-0 libnspr4 libnss3 \
    libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 libxss1 libxtst6 \
    libgtk-3-0 libxshmfence1 libxcb-dri3-0 libgbm1 && \
    rm -rf /var/lib/apt/lists/*

# Tạo thư mục app và copy code vào
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Cài Playwright và các browser
RUN playwright install --with-deps

COPY app ./app

# Mở cổng 8000 và chạy server
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
