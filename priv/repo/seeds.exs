alias Zheshmowen.{Languages, Accounts}

{:ok, user} =
  Accounts.create_user(%{
    name: "mark",
    email: "mark@test.com",
    password: "insecure_password1",
    photo_url: "https://some-fake-image.com",
    affiliation: "Citizen Potawatomi Nation"
  })

{:ok, group} = Languages.create_group(%{name: "Bodéwadmimwen"})

Languages.add_user_to_group(%{user_id: user.id, group_id: group.id})
