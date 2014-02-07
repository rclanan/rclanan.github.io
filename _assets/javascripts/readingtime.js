Countable.once($('.content')[0], function (counter) {
    var wpm = 200,
            estimatedRaw = counter.words / wpm,
            minutes = Math.round(estimatedRaw);

        var effectiveTime = (minutes < 1) ? "a couple of secs" : minutes + " min read";

        $('.reading-time').html(effectiveTime);
        $('.reading-time').tooltip({ title: "Based on an avg reading speed of " + wpm + " wpm (words per minute)"});
});
