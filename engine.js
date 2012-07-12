function startThrow() {
//    console.log("count: " + count);
    if (appWindow.throwing == true) {
        if (count < 88) {
            //throwing from 0 - 100 steps
            count += 1;
            paper.y = appWindow.height - (Math.sin(count/100*2.5264)*(appWindow.height / 854 * 700));
            console.log("Paper y: " + paper.y);
            paper.x = paper.x + ((appWindow.wind / 2.5641) + ((finalMouseX - (appWindow.width / 2))/100));
        } else if (count == 88 ) {
            count += 1;
            if (paper.x > 190 && paper.x < 250) {
                //considered in
                appWindow.score += 1;
                paper.x = 215;
                paper.y = appWindow.height - (Math.sin(count/100*2.5264)*(appWindow.height / 854 * 700));
                appWindow.dropping = true;
            } else if (paper.x > 160 && paper.x <= 190) {
                //left rebound
                appWindow.rebound = 1;
                paper.y = appWindow.height - (Math.sin(count/100*2.5264)*(appWindow.height / 854 * 700));
            } else if (paper.x < 270 && paper.x >= 250 ) {
                //right rebound
                appWindow.rebound = 2;
                paper.y = appWindow.height - (Math.sin(count/100*2.5264)*(appWindow.height / 854 * 700));
            } else {
                //considered miss
                appWindow.score = 0;
                paper.y = appWindow.height - (Math.sin(count/100*2.5264)*(appWindow.height / 854 * 700));
                paper.x = paper.x + ((appWindow.wind / 2.5641) + ((finalMouseX - 240)/100));
            }
        } else if (count < 100) {
            count += 1;
            paper.y = 854 - (Math.sin(count/100*2.5264)*700);
            if (appWindow.rebound == 1) {
                //left rebound
                paper.x -= 5;
                paper.y = appWindow.height - (Math.sin(88/100*2.5264)*(appWindow.height / 854 * 700)) - ((Math.sin((count - 88)/11 * 2.0944 + 1.0472) - Math.sin(1.06472))*paperBin.height);
                console.log(paper.y);
            } else if (appWindow.rebound == 2) {
                //right rebound
                paper.x += 5;
                paper.y = appWindow.height - (Math.sin(88/100*2.5264)*(appWindow.height / 854 * 700)) - ((Math.sin((count - 88)/11 * 2.0944 + 1.0472) - Math.sin(1.06472))*paperBin.height);
                console.log(paper.y);
            } else {
                //no rebound, paper.x remains
                paper.y = appWindow.height - (Math.sin(count/100*2.5264)*(appWindow.height / 854 * 700));
            }
        } else if (count == 200) {
            //count till 300, end throwing, reset
            count = 0;
            appWindow.throwing = false;
            frameTimer.stop();
            paper.x = appWindow.oriX;
            paper.y = appWindow.oriY;
            appWindow.wind = (Math.round(Math.random()*200) / 20 - 5).toFixed(2);
            appWindow.dropping = false;
            appWindow.rebound = 0;
        } else {
            //cool down steps, 201-300, stop throwing
            count += 1;
        }
    }
}
