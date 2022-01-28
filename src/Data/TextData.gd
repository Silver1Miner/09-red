class_name TextData
extends Resource

var overworld_text := {
	0: {
		"0": {"name":"", "profile":"oldman",
		"text":"So we have a deal?"},
		"1": {"name":"", "profile":"agent",
		"text":"We do, Old Man. Sounds simple enough. Secure the intel inside Nine enemy towers."},
		"2": {"name":"", "profile":"oldman",
		"text":"I'm only giving the access codes to you. Do not share them. It has to be you that takes the intel in each tower."},
		"3": {"name":"", "profile":"agent",
		"text":"No worries. I don't expect this job to be too hard."},
	},
	1: {
		"0": {"name":"", "profile":"notoldman",
		"text":"I'm surprised and rather disappointed. You've already lost one of the nine towers I hired you to guard."},
		"1": {"name":"", "profile":"blu",
		"text":"Only because we were taking by surprise. I will not lose another tower."},
		"2": {"name":"", "profile":"blu",
		"text":"As I recall, our deal was that we would receive payment so long as at least one tower was held?"},
		"3": {"name":"", "profile":"notoldman",
		"text":"Indeed. Better not lose the remaining eight towers then."},
	},
	2: {
		"0": {"name":"", "profile":"agent",
		"text":"Seven towers left!"},
	},
	3: {
		"0": {"name":"", "profile":"agent",
		"text":"Six towers left!"},
	},
	4: {
		"0": {"name":"", "profile":"agent",
		"text":"Five towers left!"},
	},
	5: {
		"0": {"name":"", "profile":"agent",
		"text":"Four towers left!"},
	},
	6: {
		"0": {"name":"", "profile":"agent",
		"text":"Three towers left!"},
	},
	7: {
		"0": {"name":"", "profile":"agent",
		"text":"Two towers left!"},
	},
	8: {
		"0": {"name":"", "profile":"agent",
		"text":"One tower left!"},
	},
	9: {
		"0": {"name":"", "profile":"agent",
		"text":"You completed all missions!"},
		"1": {"name":"", "profile":"agent",
		"text":"You can replay any mission at any time."},
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
		"text":"So you're the tactical officer I've heard so much about. I'm the Agent."},
		"1": {"name":"", "profile":"agent",
		"text":"I'm the one with green lens goggles on the resupply tower."},
		"2": {"name":"", "profile":"agent",
		"text":"My job is to get down to the blue tower and capture it."},
		"3": {"name":"", "profile":"agent",
		"text":"Your job is to get me there, I guess. But no worries, you're not alone"},
		"4": {"name":"", "profile":"scout",
		"text":"Yep! You've got me, the Ranger, to help. I'm the one with the cap and knapsack."},
		"5": {"name":"", "profile":"scout",
		"text":"Use me to help escort the Agent to the enemy tower. I'm at your command."},
		"6": {"name":"", "profile":"medic",
		"text":"And I'm the Medic. I won't be going on the field for now, but I'll patch up the units in between missions."},
		"7": {"name":"", "profile":"medic",
		"text":"On the battlefield itself, you'll have to rely on the red resupply stations to heal up."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! One tower down, eight more to go."},
		"1": {"name":"", "profile":"agent",
		"text":"This is going to be easy!"},
		},
	},
	2: {
		"start": {
		"0": {"name":"red", "profile":"sniper",
		"text":"Sharpshooter, reporting for duty."},
		"1": {"name":"red", "profile":"sniper",
		"text":"Use me to take out enemies from afar."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! Two towers down, seven more to go."},
		},
	},
	3: {
		"start": {
		"0": {"name":"red", "profile":"medic",
		"text":"Good news, we got some a rocket launcher assigned to our team."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! Three towers down, six more to go."},
		},
	},
	4: {
		"start": {
		"0": {"name":"", "profile":"tank",
		"text":"Tank driver, reporting for duty."},
		"1": {"name":"", "profile":"tank",
		"text":"I can take a great deal of punishment to help shield teammates."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! Four towers down, five more to go."},
		},
	},
	5: {
		"start": {
		"0": {"name":"", "profile":"medic",
		"text":"We got a mobile grenadier assigned to our team!"},
		"1": {"name":"", "profile":"medic",
		"text":"He can rain down explosive fire from afar."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! Five towers down, four more to go."},
		},
	},
	6: {
		"start": {
		"0": {"name":"", "profile":"sapper",
		"text":"Hi! I'm the combat engineer! Maybe you don't remember me though..."},
		"1": {"name":"", "profile":"medic",
		"text":"Ahem."},
		"2": {"name":"", "profile":"sapper",
		"text":"Er, right. Anyways, I can build resupply towers on tower foundations, to help keep us healed up."},
		"3": {"name":"", "profile":"sapper",
		"text":"I can also build bridges on bridge foundations to help cross rivers more quickly!"},
		"4": {"name":"", "profile":"sapper",
		"text":"Deploy me as you see fit!"},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! Six towers down, three more to go."},
		},
	},
	7: {
		"start": {
		"0": {"name":"", "profile":"medic",
		"text":"Well, looks like it's time for me to personally take the field."},
		"1": {"name":"", "profile":"medic",
		"text":"The enemy has deployed Flamers. They can set us on fire, dealing continuous damage through burns."},
		"2": {"name":"", "profile":"medic",
		"text":"Use me to keep everyone healed up, especially against burns."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! Seven towers down, two more to go."},
		},
	},
	8: {
		"start": {
		"0": {"name":"", "profile":"medic",
		"text":"Now we've got a Flamer of our own!"},
		"1": {"name":"", "profile":"medic",
		"text":"Let's see how they like being burned up."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! Eight towers down, one more to go."},
		},
	},
	9: {
		"start": {
		"0": {"name":"", "profile":"agent",
		"text":"Well, this is the final tower."},
		"1": {"name":"", "profile":"agent",
		"text":"Looks like the enemy will be throwing everything they have left against us."},
		"2": {"name":"", "profile":"agent",
		"text":"Too bad for them though, we've got the whole gang gathered and ready to take them on."},
		},
		"lose": {
		"0": {"name":"", "profile":"medic",
		"text":"No! Our Agent was taken out!"},
		"1": {"name":"", "profile":"medic",
		"text":"We can't complete the mission without him! Let's withdraw for now. I'll patch him up and we can try again."},
		},
		"win": {
		"0": {"name":"", "profile":"agent",
		"text":"We did it! We completed our mission!"},
		"1": {"name":"", "profile":"agent",
		"text":"Truly nothing can stand in the way of the Red Nine!"},
		"2": {"name":"", "profile":"medic",
		"text":"I don't recall agreeing to that name."},
		},
	},
}
