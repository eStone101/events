document.addEventListener("DOMContentLoaded", function () {
    
    const events = document.getElementById("events");

    if (!events) {
        return;
    }

    events.addEventListener("click", function (event) {

        const date = new Date();

        const formattedDate = date.toLocaleString('de-DE');

        event.target.dispatchEvent(new CustomEvent("notify", {
            bubbles: true,
            detail: {
                text: formattedDate + " - Events!"
            },
        }));

    });

});
