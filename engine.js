function startThrow() {
//    console.log("count: " + count);
    if (appWindow.throwing == true) {
        if (count < 89) {
            //throwing from 0 - 100 steps
            count += 1;
            paper.y = appWindow.height - (Math.sin(count/100*2.5507)*(appWindow.height / 854 * 700));
//            console.log("Paper y: " + paper.y);
            paper.x = paper.x + ((appWindow.wind / 2.5641) + ((finalMouseX - (appWindow.width / 2))/100));
            paper.width -= 20/88;
            paper.height -= 20/88;
        } else if (count == 89 ) {
            count += 1;
            if ( paper.x > (paperBin.x - paper.width / 5 * 2)  && paper.x < (paperBin.x + paperBin.width - paper.width / 5 * 2) ) {
                //considered in
                appWindow.score += 1;
                paper.x = paperBin.x + ((paperBin.width - paper.width) / 2);
                paper.y = appWindow.height - (Math.sin(count/100*2.5507)*(appWindow.height / 854 * 700));
                appWindow.dropping = true;
            } else if ( paper.x > (paperBin.x - paper.width) && paper.x <= (paperBin.x - paper.width / 5 * 2) ) {
                //left rebound
                appWindow.rebound = 1;
                paper.y = appWindow.height - (Math.sin(count/100*2.5507)*(appWindow.height / 854 * 700));
            } else if ( paper.x < (paperBin.x + paperBin.width) && paper.x >= (paperBin.x + paperBin.width - paper.width / 5 * 2) ) {
                //right rebound
                appWindow.rebound = 2;
                paper.y = appWindow.height - (Math.sin(count/100*2.5507)*(appWindow.height / 854 * 700));
            } else {
                //considered miss
                appWindow.score = 0;
                paper.y = appWindow.height - (Math.sin(count/100*2.5507)*(appWindow.height / 854 * 700));
                paper.x = paper.x + ((appWindow.wind / 2.5641) + ((finalMouseX - 240)/100));
            }
        } else if (count < 100) {
            count += 1;
            paper.y = 854 - (Math.sin(count/100*2.5264)*700);
            if (appWindow.rebound == 1) {
                //left rebound
                paper.x -= 5;
                paper.y = appWindow.height - (Math.sin(89/100*2.5507)*(appWindow.height / 854 * 700)) - ((Math.sin((count - 89)/11 * 2.0944 + 1.0472) - Math.sin(1.0472))*(paperBin.height / 0.866));
//                console.log(paper.y);
            } else if (appWindow.rebound == 2) {
                //right rebound
                paper.x += 5;
                paper.y = appWindow.height - (Math.sin(89/100*2.5507)*(appWindow.height / 854 * 700)) - ((Math.sin((count - 89)/11 * 2.0944 + 1.0472) - Math.sin(1.0472))*(paperBin.height / 0.866));
//                console.log(paper.y);
            } else {
                //no rebound, paper.x remains
                paper.y = appWindow.height - (Math.sin(count/100*2.5507)*(appWindow.height / 854 * 700));
            }
        } else if (count == 200) {
            //count till 300, end throwing, reset
            count = 0;
            paper.width = paper.height = 50;        //reset the paper size
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
