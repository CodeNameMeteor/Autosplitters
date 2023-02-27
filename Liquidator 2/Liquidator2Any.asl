state("Liquidator2Launcher")
{
    int gameState : "TMKernel.dll", 0x14895C;
    bool inControl: "TMGameLoader.dll", 0x5FF00;
    bool levelSelect : "TMD3DGil.dll", 0x163B30;
    int level : "TMRtl.dll", 0x1993C8;
    int inEndingScreen : "TMRtl.dll", 0x183B38; //When in ending screen it's 1801609066
}
init{
    vars.loading = 0; // to prevent multiple splits when loading into another area during a level
    vars.inLevelEnd = 0;

}
isLoading
{
    if(current.gameState == 257){
        vars.inLevelEnd = 0;
        return true;
    }else if(current.gameState != 257){
        vars.loading = 0;
        return false;
    }
}
split
{
    if((current.inEndingScreen == 1801609066 && vars.inLevelEnd == 0) || current.level != old.level && (current.inControl == true) && vars.loading == 0){
        vars.inLevelEnd = 1;
        vars.loading = 1;
        return true;
    } 
}

start
{
    if(old.levelSelect == true && current.levelSelect == false){
        return true;
    }
}
onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
    vars.loading = 0;
    vars.inLevelEnd = 0;
}
exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}

