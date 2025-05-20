function sSTimer(ply, button)
    print("Called!")
    if button == KEY_LSHIFT then
        print("You're sprinting!")
    end
end

hook.Add("PlayerButtonDown", "StartSprintTimer", sSTimer)