const secretInput = document.getElementById("secret");
const status = document.getElementById("status");

chrome.storage.local.get("writeSecret", function (data) {
    if (data.writeSecret) {
        secretInput.value = data.writeSecret;
    }
});

document.getElementById("save").addEventListener("click", function () {
    chrome.storage.local.set({ writeSecret: secretInput.value }, function () {
        status.textContent = "Saved.";
        setTimeout(function () { status.textContent = ""; }, 1500);
    });
});
