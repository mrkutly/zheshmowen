# User Stories

## Language groups

- Moderators can start language groups
- Moderators can ban users from language groups

## Posts

- Users can create posts
- Users can comment on posts
- Users can like posts

## Classes

- Users can start classes as a host
- Users can join classes as a participant

## Profiles

- Users can upload a photo
- Users can add their affiliations

# Models

Users - migrated
 - name!
 - email!
 - affiliation?
 - photo_url?
 
Language Group Users - migrated
 - group_id!
 - user_id!
 - is_admin! default false

Language Groups - migrated
 - name!

Posts
 - user_id!
 - group_id!
 - body!
 - num_likes default 0
 
Post Comments
 - post_id!
 - user_id!
 - body!
 - num_likes default 0

Classes
 - start_time!
 - end_time!
 - admin_user_id!

Class Participants
 - class_id!
 - user_id!


# TODO

- Setup DB tables
- Decide on contexts
- Setup auth strategy (OAuth with gmail, fb, whatever)


