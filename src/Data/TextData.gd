class_name TextData
extends Resource

var overworld_text := {
	0: {
		"0": {"name":"", "profile":"oldman",
		"text":"So we have a deal?"},
		"1": {"name":"", "profile":"agent",
		"text":"We do, Old Man. Sounds simple enough. Three enemy towers; secure the intel inside."},
		"2": {"name":"", "profile":"oldman",
		"text":"I'm only giving the access codes to you. Do not share them. It has to be you that takes each tower."},
		"3": {"name":"", "profile":"agent",
		"text":"No worries. I don't expect this job to be too hard."},
	},
	1: {
		"0": {"name":"", "profile":"notoldman",
		"text":"I'm surprised and rather disappointed. You've already lost one of the three towers I hired you to guard."},
		"1": {"name":"", "profile":"blu",
		"text":"Only because we were taking by surprise. I will not lose another tower."},
		"2": {"name":"", "profile":"blu",
		"text":"As I recall, our deal was that we would receive payment so long as at least one tower was held?"},
		"3": {"name":"", "profile":"notoldman",
		"text":"Indeed. Better not lose the remaining two towers then."},
	},
	2: {
		"0": {"name":"", "profile":"notoldman",
		"text":"Hmm, seems you're down to your last tower."},
		"1": {"name":"", "profile":"blu",
		"text":"But so long as I hold it, your payment is still due."},
		"2": {"name":"", "profile":"blu",
		"text":"Just you watch. I will not lose again."},
	},
	3: {
		"0": {"name":"", "profile":"agent",
		"text":"You completed all missions!"},
		"1": {"name":"", "profile":"agent",
		"text":"You can replay them at any time."},
	},
}

var level_text := {
	0: {
		"start": {
		"0": {"name":"red", "profile":"red",
		"text":"Well, this is the test mission"},
		"1": {"name":"red", "profile":"red",
		"text":"Try not to die!"},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"red", "profile":"red",
		"text":"Congratulations!"},
		"1": {"name":"red", "profile":"red",
		"text":"We won the test mission!"},
		},
	},
	1: {
		"start": {
		"0": {"name":"", "profile":"agent",
		"text":"So you're the tactical officer I've heard so much about. I'm the agent."},
		"1": {"name":"", "profile":"agent",
		"text":"I'm the one with green lens goggles on the resupply tower."},
		"2": {"name":"", "profile":"agent",
		"text":"My job is to get down to the blue tower and capture it. Your job is to keep me alive."},
		"3": {"name":"", "profile":"agent",
		"text":"Your job is to get me there alive, I guess."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! One tower down, two more to go."},
		"1": {"name":"", "profile":"agent",
		"text":"This is going to be easy!"},
		},
	},
	2: {
		"start": {
		"0": {"name":"red", "profile":"agent",
		"text":"Well look at that, the back-up I called in arrived!"},
		"1": {"name":"red", "profile":"tank",
		"text":"Hmm."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"red", "profile":"red",
		"text":"Congratulations!"},
		"1": {"name":"red", "profile":"red",
		"text":"We won the test mission!"},
		},
	},
	3: {
		"start": {
		"0": {"name":"", "profile":"medic",
		"text":"Well, this is the last tower. Looks like the enemy's going all in, so we are too."},
		"1": {"name":"", "profile":"medic",
		"text":"Which means I'll be on the field too. You can use me to patch my teammates up, in addition to the resupply towers. And speaking of them..."},
		"2": {"name":"", "profile":"sapper",
		"text":"Hi! I'm the combat engineer! Maybe you don't remember me though..."},
		"3": {"name":"", "profile":"medic",
		"text":"Ahem."},
		"4": {"name":"", "profile":"sapper",
		"text":"Er, right. Anyways, I can build resupply towers on tower foundations, plus bridges on bridge foundations."},
		"5": {"name":"", "profile":"sapper",
		"text":"Deploy me as you see fit!"},
		"6": {"name":"", "profile":"medic",
		"text":"We've also got a Flamer joining up with us. He's pretty simple. He burns up enemies."},
		"7": {"name":"", "profile":"medic",
		"text":"The enemy has Flamers too though, and they'll set us on fire. Use me or a resupply tower to take care of burns."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"red", "profile":"red",
		"text":"Congratulations!"},
		"1": {"name":"red", "profile":"red",
		"text":"We won the test mission!"},
		},
	},
}
