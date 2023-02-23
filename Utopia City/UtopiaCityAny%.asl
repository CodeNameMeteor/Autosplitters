state("UtopiaLauncher")
{
    int artefactCount : "TMUtopia.dll", 0x127548, 0x60; //increments everytime the player has picked up an artefact
    int gameState : "TMKernel.dll", 0x1186FC; //65536 when the start and end cutscene is played, 256 when loading, 0 when game active, 1 when in menu/main menu
}
isLoading
{
    if(current.gameState == 256){
        return true;
    }else if(current.gameState != 256){
        return false;
    }
}
split
{
    if((current.artefactCount > old.artefactCount) && old.gameState != 256|| current.gameState == 65536){
        return true;
    } 
}
start
{
    if(current.gameState == 256){
        return true;
    }
}
onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}
exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}
