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
		"text":"Only because we were taken by surprise. I will not lose another tower."},
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
		"text":"Congratulations! You've completed all the missions!"},
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
		"text":"Your job is to get me there, I guess. Move me onto the tower, and I will have a capture option."},
		"4": {"name":"", "profile":"agent",
		"text":"But don't worry, it won't be just you and me."},
		"5": {"name":"", "profile":"medic",
		"text":"Medic, reporting for duty. I won't be going on the field for now, but I'll patch the agent back up to full health in between missions."},
		"6": {"name":"", "profile":"medic",
		"text":"On the battlefield itself, you'll have to rely on the red resupply stations to heal up. Rest a guy on a tower, and he'll heal up each turn he's on it."},
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
		"0": {"name":"", "profile":"agent",
		"text":"We no longer have the element of surprise, so I called in some reinforcements."},
		"1": {"name":"", "profile":"agent",
		"text":"While I'm the only one who can capture a tower, my two buddies here have their own unique skills."},
		"2": {"name":"", "profile":"scout",
		"text":"Yep! You've got me, the Ranger, to help. I'm the one with the cap and knapsack."},
		"3": {"name":"", "profile":"scout",
		"text":"I can cover a lot of ground and help clear the way with my trusty shotgun. I'm at your command!"},
		"4": {"name":"red", "profile":"sniper",
		"text":"Sharpshooter, reporting for duty."},
		"5": {"name":"red", "profile":"sniper",
		"text":"I have decent range. Use me to take out enemies from afar."},
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
		"0": {"name":"red", "profile":"rocket",
		"text":"Rocket Launcher unit, reporting for duty!"},
		"1": {"name":"red", "profile":"rocket",
		"text":"I'm a tough all-around soldier that can hopefully give you a bit more firepower."},
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
		"1": {"name":"", "profile":"grenade",
		"text":"Reporting for duty! I can rain down explosive fire from afar."},
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
		"1": {"name":"", "profile":"flamer",
		"text":"..."},
		"2": {"name":"", "profile":"medic",
		"text":"Er... our flamer isn't exactly chatty..."},
		"3": {"name":"", "profile":"medic",
		"text":"But no matter. Let's see how the enemy likes being burned up!"},
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
