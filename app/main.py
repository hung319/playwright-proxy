from fastapi import FastAPI
from fastapi.responses import PlainTextResponse
from playwright.sync_api import sync_playwright

app = FastAPI()

@app.get("/bypass", response_class=PlainTextResponse)
def bypass_cf(url: str):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        page.goto(url, timeout=60000)
        content = page.content()
        browser.close()
        return content
