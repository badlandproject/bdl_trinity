local cfg = {}

cfg.groups = {
	["founder"] = {
		_config = {
			title = "founder"
		},
		"founder.permission",
		"staff.permission"
	},
	["manager"] = {
		_config = {
			title = "manager"
		},
		"manager.permission",
		"staff.permission"
	},
	["admin"] = {
		_config = {
			title = "admin"
		},
		"admin.permission",
		"staff.permission"
	},
	["mod"] = {
		_config = {
			title = "mod"
		},
		"mod.permission",
		"staff.permission"
	},
	["support"] = {
		_config = {
			title = "support"
		},
		"support.permission",
		"trial.permission",
		"staff.permission"
	},

	["pass-basic"] = {
		_config = {
			title = "Básico",
			gtype = "pass"
		},
		"basic.pass",
		"pass.permission"
	},

	["pass-intermediate"] = {
		_config = {
			title = "Intermediário",
			gtype = "pass"
		},
		"intermediate.pass",
		"pass.permission"
	},

	["pass-advanced"] = {
		_config = {
			title = "Avançado",
			gtype = "pass"
		},
		"advanced.pass",
		"pass.permission"
	},

	["pass-plus"] = {
		_config = {
			title = "Plus",
			gtype = "pass"
		},
		"plus.pass",
		"pass.permission"
	},

	-- [ LSPD - JOB ] --
	["lspd"] = {
		_config = {
			title = "LS - Policia",
			gtype = "job"
		},
		"lspd.permission",
	},
	["off-lspd"] = {
		_config = {
			title = "F. Serviço - LSPD",
			gtype = "job"
		},
		"off-lspd.permission",
	},
	-- [ LSPD - POSITIONS ] --
	["lspd-cadete"] = {
		_config = {
			title = "Cadete",
			gtype = "position"
		},
		"cadete.permission",
	},
	["lspd-officerjr"] = {
		_config = {
			title = "Oficial Jr.",
			gtype = "position"
		},
		"officerjr.permission",
	},
	["lspd-officersr"] = {
		_config = {
			title = "Oficial Sr.",
			gtype = "position"
		},
		"officersr.permission",
	},
	["lspd-detective"] = {
		_config = {
			title = "Detetive",
			gtype = "position"
		},
		"detective.permission",
	},
	["lspd-sargeant"] = {
		_config = {
			title = "Sargento",
			gtype = "position"
		},
		"sargeant.permission",
	},
	["lspd-lieutenant"] = {
		_config = {
			title = "Tenente",
			gtype = "position"
		},
		"lieutenant.permission",
	},
	["lspd-captain"] = {
		_config = {
			title = "Capitão",
			gtype = "position"
		},
		"captain.permission",
	},
	["lspd-comissioner"] = {
		_config = {
			title = "Comissário",
			gtype = "position"
		},
		"comissioner.permission",
	},

	-- [ EMS - JOB ] --
	["ems"] = {
		_config = {
			title = "LS - Hospital",
			gtype = "job"
		},
		"ems.permission",
	}, 
	["off-ems"] = {
		_config = {
			title = "F. Serviço - EMS",
			gtype = "job"
		},
		"off-ems.permission",
	}, 
	-- [ EMS - POSITIONS ] --
	["ems-intern"] = {
		_config = {
			title = "Estagiário(a)",
			gtype = "position"
		},
		"intern.permission",
	},

	["ems-nurse"] = {
		_config = {
			title = "Enfermeiro(a)",
			gtype = "position"
		},
		"nurse.permission",
	},

	["ems-paramedic"] = {
		_config = {
			title = "Paramédico(a)",
			gtype = "position"
		},
		"nurse.permission",
	},

	["ems-medic"] = {
		_config = {
			title = "Médico(a)",
			gtype = "position"
		},
		"medic.permission",
	},

	["ems-clinic"] = {
		_config = {
			title = "Clinico(a) Geral",
			gtype = "position"
		},
		"clinic.permission",
	},

	["ems-vicedirector"] = {
		_config = {
			title = "Vice Diretor(a)",
			gtype = "position"
		},
		"vicedirector.permission",
	},

	["ems-director"] = {
		_config = {
			title = "Diretor(a)",
			gtype = "position"
		},
		"director.permission",
	},

	-- [ BENNYS - JOB ] --
	["bennys"] = {
		_config = {
			title = "LS - Benny's",
			gtype = "job"
		},
		"bennys.permission",
	},

	["off-bennys"] = {
		_config = {
			title = "F. Serviço - Benny's",
			gtype = "job"
		},
		"off-bennys.permission",
	},

	-- [ BENNYS - POSITIONS ] --
	["bennys-tow"] = {
		_config = {
			title = "Guincho",
			gtype = "position"
		},
		"tow.permission",
	},

	["bennys-mechanic"] = {
		_config = {
			title = "Mecânico",
			gtype = "position"
		},
		"mechanic.permission",
	},

	["bennys-manager"] = {
		_config = {
			title = "Gerente",
			gtype = "position"
		},
		"manager.permission",
	},

	["bennys-ceo"] = {
		_config = {
			title = "C.E.O",
			gtype = "position"
		},
		"bennysceo.permission",
	},

	-- [ ILEGAL ] --
	-- [ GANGUES DE RUA ] --
	-- [ Grove ] --
	["grove"] = {
		_config = {
			title = "Grove St.",
			gtype = "job"
		},
		"grove.permission",
		"ilegal.permission"
	},

	["l-grove"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-grove.permission",
	},

	["m-grove"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-grove.permission",
	},

	-- [ Ballas ] --
	["ballas"] = {
		_config = {
			title = "Ballas",
			gtype = "job"
		},
		"ballas.permission",
		"ilegal.permission"
	},

	["l-ballas"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-ballas.permission",
	},

	["m-ballas"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-ballas.permission",
	},

	-- [ Vagos ] --
	["vagos"] = {
		_config = {
			title = "Vagos",
			gtype = "job"
		},
		"vagos.permission",
		"ilegal.permission"
	},

	["l-vagos"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-vagos.permission",
	},

	["m-vagos"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-vagos.permission",
	},

	-- [ GANGUES DE ARMA/MUNIÇÃO ] --
	-- [ Bratva ] --

	["bratva"] = {
		_config = {
			title = "Bratva",
			gtype = "job"
		},
		"bratva.permission",
		"ilegal.permission"
	},

	["l-bratva"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-bratva.permission",
	},

	["m-bratva"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-bratva.permission",
	},

	-- [ LC ] --

	["lc"] = {
		_config = {
			title = "Los Cuervos",
			gtype = "job"
		},
		"lc.permission",
		"ilegal.permission"
	},

	["l-lc"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-lc.permission",
	},

	["m-lc"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-lc.permission",
	},

	-- [ M.C ] --

	["lost"] = {
		_config = {
			title = "Lost MC",
			gtype = "job"
		},
		"lost.permission",
		"ilegal.permission"
	},

	["l-lost"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-lost.permission",
	},

	["m-lost"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-lost.permission",
	},
}


cfg.users = {
	[1] = { "founder" },
	[2] = { "manager" }
}

cfg.selectors = {}

return cfg