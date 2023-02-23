state("UtopiaLauncher")
{
    bool isLoading : "TMD3DGil.dll", 0x26F850, 0xCC, 0x34, 0x24, 0x4, 0x0, 0x8, 0x10; //0 when not loading, 1 when loading
    int artefactCount : "TMUtopia.dll", 0x127548, 0x60; //increments everytime the player has picked up an artefact
    int inCutscene : "TMKernel.dll", 0x1186FC; //65536 when the start and end cutscene is played, 256 when loading
}
init
{
    vars.teleportControlGrabbed = 0; //Initialises the teleportControlGrabbed variable, stores whether or not the player has the teleport control artefact
}
isLoading
{
    return current.isLoading;
}


split
{
    if((current.artefactCount == 1 && old.artefactCount == 0 && vars.teleportControlGrabbed == 0) || (current.artefactCount > old.artefactCount && vars.teleportControlGrabbed == 1 && old.artefactCount > 0)|| current.inCutscene == 65536){
        vars.teleportControlGrabbed = 1;
        return true;
    } 
}

start
{
    if(current.inCutscene == 256){
        vars.teleportControlGrabbed = 0;
        return true;
    }
}
