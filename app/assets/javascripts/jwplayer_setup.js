$(document).on("turbolinks:load", function() {

  // Embed JWplayer
  var controller = $("body").data("controller");
  var action = $("body").data("action");

  if ((controller !== "videos" && controller !== "embeds") || action !== "show") {
    return;
  }

  var playerInstance = jwplayer("browzable-video");
  var playDuration = 10;
  var counter = 0;
  var prevPosition = 0;
  var balance = $("#balance").data("balance");
  var videoId = $(".browzable-wrapper").data("videoId");
  
  playerInstance.setup({
    autostart: "true",
    playlist: [{ 
      file: $(".browzable-wrapper").data("url"),
      withCredentials: true
    }]
  });

  jwplayer().on('ready', function() {
    var playerBalance = $(".minutes-balance").clone();
    
    $(".jw-spacer").after(playerBalance);
    playerBalance.show();
  });

  if (controller === "videos") {
    jwplayer().on('viewable', function() {
      $(".video-info-container").show();
    });
  }

  //inaccurate timekeeping
  jwplayer().on('time', function(time) {
    counter += time.position - prevPosition;
    prevPosition = time.position;
    if (counter > playDuration) {
      sendPlay();
      counter -= playDuration;
    }
  });

  jwplayer().on('seeked', function() {
    counter = 0;
  });
 

  //post to server

  function sendPlay() {
    var playData = { play: {video_id: videoId, duration: playDuration} }
    var request = $.ajax({
      url: "/plays",
      method: "POST",
      data: playData,
      dataType: "html"
    });
    console.log(request);
    console.log(balance);

    request.done(function( msg ) {
      updateBalance();
    });
  }

  function updateBalance () {
    balance -= playDuration;
    if (balance < 10) {
      window.location.href = "/charges/new";
    }
    $("#balance")[0].innerHTML = Math.floor(balance/60);
  }
});