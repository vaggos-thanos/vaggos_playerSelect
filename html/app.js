window.addEventListener("message", function(event) {
    switch (event.data.action) {
        case "open":
            $('#mainMenu').css('display', 'flex');
            this.document.body.style.backgroundColor = "#0000005b"
            loadPlayers(JSON.parse(event.data.players));
        break;

        case 'exit':
            $('#mainMenu').fadeOut(500)
            this.document.body.style.backgroundColor = "#00000000"
        break;
    }
})

$(document).keyup(async (e) => {
    if (e.key === "Escape") {
        setTimeout(async () => {
            $.post('https://vaggos_playerSelect/exit', JSON.stringify({}));
        }, 300);
    }
});

async function loadPlayers(players) {
    console.log(players.length)
    for ( const player of players) {
        console.log(player.name);
        $(`#playerImges`).append(`<button><img id="${player.id}" src="${player.avatarURL}" /></button>`);
        $(`#${player.id}`).click(function() {
            $.post('https://vaggos_playerSelect/selectedPlayer', JSON.stringify({
                id: player.id,
                name: player.name,
                avatarURL: player.avatarURL,
            }));
        })
    }
}