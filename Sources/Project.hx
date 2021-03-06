package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import sdg.Engine;
import sdg.manager.GamePadMan;
import sdg.Sdg;
//import screens.PlayScreen;
import sdg.manager.Manager.*;
import kha.audio1.Audio;
import kha.audio1.AudioChannel;
//import systems.Data;

class Project {
	public function new() {
		Assets.loadEverything(assetsLoaded);
	}

	function assetsLoaded()
	{
		var engine = new Engine(960, 720, false, true, 60);
		engine.enable(KEYBOARD | MOUSE | GAMEPAD | DELTA);
		
		Sdg.addScreen('Play', new PlayScreen());
		Sdg.addScreen('Credits', new CreditsScreen());
		Sdg.addScreen('Title', new TitleScreen(), true);

		var ac = Audio.play(Assets.sounds.sandhammaren1, true);

		ac.volume = .4;

		System.notifyOnRender(engine.render);
		Scheduler.addTimeTask(engine.update, 0, 1 / 60);

		util.ButtonManager.the;

	}
}
