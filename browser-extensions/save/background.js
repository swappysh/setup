chrome.action.onClicked.addListener(async function (tab) {
    const { writeSecret } = await chrome.storage.local.get("writeSecret");
    if (!writeSecret) {
        chrome.runtime.openOptionsPage();
        return;
    }
    chrome.scripting.executeScript({
        target: { tabId: tab.id },
        func: savePage,
        args: [writeSecret]
    });
});

function savePage(secret) {
    const WORKER_URL = "https://saves-worker.swappysh.workers.dev";
    fetch(WORKER_URL + "/api/save", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + secret
        },
        body: JSON.stringify({
            url: window.location.href,
            title: document.title,
            source: "bookmarklet"
        })
    })
        .then(function (res) { return res.json(); })
        .then(function (data) {
            if (data.error) {
                alert("Save failed: " + data.error);
            } else {
                alert("Saved!");
            }
        })
        .catch(function (err) {
            alert("Error: " + err.message);
        });
}
