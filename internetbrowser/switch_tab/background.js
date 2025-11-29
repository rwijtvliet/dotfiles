async function getTabs() {
  return await browser.tabs.query({ currentWindow: true });
}

async function getActiveTab() {
  const [tab] = await browser.tabs.query({
    active: true,
    currentWindow: true,
  });
  return tab;
}

browser.commands.onCommand.addListener(async (command) => {
  const tabs = await getTabs();
  const active = await getActiveTab();
  if (!active) return;

  const idx = active.index;

  let targetIndex;
  if (command === "tab-left") {
    targetIndex = (idx - 1 + tabs.length) % tabs.length;
  } else if (command === "tab-right") {
    targetIndex = (idx + 1) % tabs.length;
  } else {
    return;
  }

  const targetTab = tabs[targetIndex];
  await browser.tabs.update(targetTab.id, { active: true });
});
