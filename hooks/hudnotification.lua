local MODID = "_oipmod"

Hooks:PostHook(HUDNotificationConsumablePickup, "_create_document_image", "_create_document_image" .. MODID,
	function(self, notification_data)
		local picked_up_missions = managers.consumable_missions._picked_up_missions
		local picked_up_missions_count = #picked_up_missions

		if picked_up_missions_count == 0 then
			return
		end

		local mission_data = tweak_data.operations.missions[picked_up_missions[picked_up_missions_count]]
		local mission_icon = mission_data.icon_menu

		local gui_data = tweak_data.gui.icons[mission_icon]

		local chosen_mission_image_params = {
			name = "notification_outlaw_raid_mission_hint_icon",
			layer = 4,
			texture = gui_data.texture,
			texture_rect = gui_data.texture_rect,
			color = Color(0.72, 0.13, 0.13),
			alpha = 0.9
		}

		self._folder_mission_icon = self._object:bitmap(chosen_mission_image_params)
		self._folder_mission_icon:set_center_x(self._folder_image:center_x())
	end
)

Hooks:PreHook(HUDNotificationConsumablePickup, "_fit_size", "_fit_size" .. MODID,
	function(self, notification_data)
		if self._folder_mission_icon then
			self._folder_mission_icon:set_y(165)
		end
	end
)
