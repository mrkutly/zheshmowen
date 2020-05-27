alias Zheshmowen.{Languages, Accounts}

{:ok, user} =
  Accounts.create_user(%{
    name: "mark",
    email: "mark@test.com",
    password: "insecure_password1",
    affiliation: "Citizen Potawatomi Nation"
  })

{:ok, user2} =
  Accounts.create_user(%{
    name: "brub",
    email: "brub@test.com",
    password: "insecure_password1",
    affiliation: "Prairie Band Potawatomi"
  })

{:ok, group} = Languages.create_group(%{name: "Bodéwadmimwen"})

Languages.add_user_to_group(%{user_id: user.id, group_id: group.id})

{:ok, post} =
  Languages.create_post(%{
    user_id: user.id,
    group_id: group.id,
    body: "Bozho Jayek! Mark ndezhnekas. Bodéwadmi ndaw mine shishibeniyek ndabendagwes."
  })

Languages.create_comment(%{
  user_id: user2.id,
  post_id: post.id,
  body: "Bozho Mark! Brub ndaw. Ni je na?"
})

Languages.create_comment(%{
  user_id: user.id,
  post_id: post.id,
  body: "Anwe she shena. Ni je na gin?"
})
