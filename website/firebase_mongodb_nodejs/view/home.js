var socket = io("http://localhost:4000");
var messages = document.getElementById("messages");
var form = document.getElementById("form");

form.addEventListener("submit", function (e) {
  e.preventDefault();
  socket.emit("chat message", input.value);
  input.value = "";
});
socket.on("output-message", (data) => {
  if (data.length) {
    data.forEach((message) => {
      appendMessage(message.msg);
    });
  }
  messages.appendChild(item);
  window.scrollTo(0, document.body.scrollHeight);
});

function appendMessage(message) {
  const html = `<div>${message}</div>`;
  message.innerHTML += html;
}
