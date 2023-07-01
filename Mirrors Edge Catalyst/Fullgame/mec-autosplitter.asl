//Shout-outs to the MEC community and to the following people:
//derwangler - Thank you for your years of hard work in reverse engineering this game!
//Psp4804 - For the original autosplitter (https://github.com/bentokend/catalyst-autosplitter)
//tremwil - For the CatalystNoclip tool (https://github.com/tremwil/CatalystNoclip)
 
//*Notes
//Automatically starts for all individual levels
//Reloading checkpoint while you're in Icarus Walk will cause the timer to automatically start again before the walk is finished
 
state("MirrorsEdgeCatalyst") {
	uint movementState : "MirrorsEdgeCatalyst.exe", 0x2576FDC;
    bool loading : "MirrorsEdgeCatalyst.exe", 0x240C2B8, 0x4C1;
    uint mission : "MirrorsEdgeCatalyst.exe", 0x0257C9D8, 0x20, 0x1858, 0x18;
    bool canShift : "MirrorsEdgeCatalyst.exe", 0x0257C9D8, 0x20, 0x2d0, 0x18;
    bool inCutscene : "MirrorsEdgeCatalyst.exe", 0x02577770, 0x70, 0xC0, 0, 0;
	float health : "MirrorsEdgeCatalyst.exe", 0x2547F90, 0x28, 0, 0x20;
	byte endBanner : "MirrorsEdgeCatalyst.exe", 0x0237DEB8, 0x218, 0x2f0, 0x8, 0x7bc;
	float y : "MirrorsEdgeCatalyst.exe", 0x02106A68, 0xD0, 0x128, 0x30, 0x54;
}
init {
	vars.inReleaseIntro = false;
	vars.icarusWalk = false;
    vars.vTol = false;
	vars.hasPxFightStarted = false;
    vars.pxTrain = false;
    vars.shardTrain = false;
	vars.shardCounter = 0;
	vars.timerStarted = false;
}
startup
{
	settings.Add("Release");
	settings.Add("Follow the Red", false);
	settings.Add("Old Friends");
	settings.Add("Be Like Water");
	settings.Add("Back in the Game");
	settings.Add("Mischief Maker", false);
	settings.Add("Savant Extraordinaire");
	settings.Add("Gridnode Run", false);
	settings.Add("Benefactor");
	settings.Add("Fly Trap");
	settings.Add("Sanctuary");
	settings.Add("Encroachment");
	settings.Add("Vive La Resistance");
	settings.Add("Payback", false);
	settings.Add("Prisoner X");
	settings.Add("Thy Kingdom Come");
	settings.Add("Family Matters");
	settings.Add("Tickets, Please!");
}
update {
	if (current.mission == 35) {
		//vars.icarusWalk = current.canShift ? false : current.inCutscene && !old.inCutscene && vars.inReleaseIntro ? true : vars.icarusWalk;
		//vars.icarusWalk = current.health == 0 ? false : vars.icarusWalk;
		if(current.canShift){
			vars.icarusWalk = false;
			vars.inReleaseIntro = false;
		}else if(current.inCutscene && !old.inCutscene && vars.inReleaseIntro){
			vars.icarusWalk = true;
		}
		if(current.health == 0){
			vars.icarusWalk = false;
		}
		if(current.inCutscene && !vars.inReleaseIntro){
			vars.inReleaseIntro = true;
		}
		//vars.inReleaseIntro = current.canShift ? false : current.inCutscene && vars.inReleaseIntro == false ? true : vars.inReleaseIntro;
	} else {
		vars.inReleaseIntro = false;
		vars.icarusWalk = false;
	}
 
	if (current.mission == 77) {
		vars.vTol = current.movementState != 0 ? false : old.movementState == 23 ? true : vars.vTol;
		vars.hasPxFightStarted = current.movementState == 26 || current.movementState == 27 || current.movementState == 20 ? true : vars.hasPxFightStarted;
		vars.hasPxFightStarted = current.health == 0 ? false : vars.hasPxFightStarted;
		vars.pxTrain = old.loading && !current.loading && vars.hasPxFightStarted ? true : vars.pxTrain;
	} else {
		vars.vTol = false;
		vars.hasPxFightStarted = false;
		vars.pxTrain = false;
	}
 
	if (current.mission == 91) {
		if ((!old.inCutscene && current.inCutscene) || (old.inCutscene && !current.inCutscene)) vars.shardCounter++;
		vars.shardTrain = vars.shardCounter < 4 ? true : false;
	} else {
		vars.shardTrain = false;
		vars.shardCounter = 0;
	}
}
split {
	if (current.endBanner == 154 && old.endBanner != 154) return true;
	if (old.y > 1400 && current.y < 100 && current.y > 10) return true; //The Shard
	return false;
}
start {
	if (current.mission == 35 && !current.inCutscene && old.inCutscene) return true;
	if (current.mission != old.mission && (old.mission == 0 && current.mission != 0 && current.mission != 35)) return true;
}
isLoading {
	return current.loading || vars.icarusWalk || vars.vTol || vars.pxTrain || vars.shardTrain;
}
reset
{
	if(current.mission == 35 && old.mission == 0 && vars.timerStarted == true) return true;
}
onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
	vars.timerStarted = true;
}
onReset
{
	vars.timerStarted = false;
}
exit
{
    timer.IsGameTimePaused = true;
}
