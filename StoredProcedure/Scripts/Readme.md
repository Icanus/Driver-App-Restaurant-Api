To Run the Migration:

Execute the following command:
- Update-Database

Recommended Approach (Instead of Migration):

Import the Latest Script into the Database:

Locate the latest script in the "Scripts" folder.
Important Tables That Should Contain Values:

1 dbo.Category
2 dbo.Item
3 dbo.SMTPConfig
4 dbo.RatePoints

For Fresh Data (Starting with Empty Tables):

Delete all values in tables not included above.
Use the "truncate" command for all tables not listed in the "Important Tables That Should Contain Values" section.
 - 3 and 4 only