## Prompt-1
# Context
* I wanted to build UI responsive web application which perfectly fit to the mobile apps and web applications using Flutter(Dart).
* The targeted audience is Tech Audience , company owners, freelancers and Application Developers (Flutter).
* for primary color use "#af3a4a" that hexcode.
* for reference you can checkout "https://www.withanimation.app".
* This web application contains Grid view of 6 flows and their subflows.
* There are total 6 flows and and all 6 flows having 71 subflows, i have mentioned about all flows and subflows following.. 

1. Account Management
Deleting & Deactivating Account
Editing Profile 
Logging In 
Logging Out 
Resetting Password 
Switching Account 

2. Commerce & Finance
Adding to Cart & Bag
Booking & Reserving 
Canceling Order & Refunding 
Canceling Subscription 
Listing 
Purchasing & Ordering 
Redeeming 
Subscribing & Upgrading
Transferring Money & Donating

3. Content
Adding & Creating 
Archiving
Copying & Duplicating 
Deleting & Removing 
Drawing
Editing & Updating 
Favoriting & Pinning 
Filtering & Sorting 
Importing & Exporting 
Listening to Audio 
Logging & Tracking 
Marking 
Moving 
Publishing 
Recording Audio & Video 
Reordering 
Saving to Collection 
Scanning 
Searching & Finding 
Selecting & Choosing 
Starting & Completing 
Taking Photos 
Uploading & Downloading  
Watching Video  

4. Misc
Connecting & Linking  
Enabling & Disabling  
Misc  
Setting Up  
Showing & Hiding  
Switching View  
Switching to Dark Mode  
Turning On/Off  
Verifying


5. New User Experience
Browsing Tutorial  
Creating Account  
Onboarding  
Onboarding Forms

6. Social
Banning & Blocking  
Calling  
Chatting & Sending Messages
Commenting & Replying  
Following & Subscribing  
Gifting  
Giving Feedback  
Inviting Teammates & Friends  
Joining & Accepting  
Leaving 
Liking & Upvoting  
Muting 
Referring Friends  
Registering  
Reporting  
Requesting  
Reviewing & Rating  
Scheduling  
Sharing 

* I am strictly guiding for the Web application and you have to adjust the UI accordingly for the Mobile screen and tablet screen. 




# Task
I'm breaking the screen in different slots 

```
Slot1 -> Header 

header is fixed on the top it will not move on scrolling the web application.

In the header there is logo and name of the website (width = 114mm for web application)
logo :- leave for now
website name :- Enterprise UI Playground

then "Flows", "Pricing", "FAQ" are arranged after the logo and website name on the left  with some horizontal spacing

a button for adjusting the theme (Default theme is light) and profile icon are arranged on the right side with some horizontal padding
```


```
Slot2 -> Introduction to the web application

This slot contains the introduction and animation of the web application.

Split a Row in two columns 

First Column having 
"BUILT WITH FLUTTER"
"Beautiful flows 'for FlutterUI'(Highlight this single quited text with some special color)" (This is the Text which should be in large Text because it shows what that website does)

Second Column having Animation which i add later so you just leave it empty for the animation

```

```
Slot3 -> Flows

In that Slot there is heading of 'Explore the flows' with bold and large font 

below that heading there are the grid view of six Flows 
Get the data from 'lib/app_router.dart'
for 'Explore the flows'

when we click on any one of them flow then a new screen opens which having header , logo ,
grid view for the no. of the subflows inside that flow, 
footer

if anyone click on any of the subflow then an editor opens 
"
Header section is same just replace "Flows, Pricing and FAQ" with "Preview" and place "Preview" on center 

below header there is a listView on the left side of all the subflows inside that flow 
and all are clickable (occupies 20% of the screen vertically)


on the right side there is a Mobile Screen on which all the flow gonna display that Mobile screen gonna work as the real mobile emulator
"
 

```

```
Slot4 -> Pricing

In that slot in the center 
"
'PRICING'(having mediun and bold text with the primary color)
'Preview every flow live \n Customize and download free \n flows.'(having bold and bigger text)
'Try every flow in the browser, make it your own, then download the free ones' (This having small text , not bold)
"

Below that there are two Containers which shows the one container is showing free, and another container is showing plus+ plans details
Generate these two container accordingly and the first container is transparent and second one having primary color in background and white color in foreground
```

```
Slot5 -> FAQ

In that slot in the center of the screen there are 'Have any questions?' (having bold and bigger test)

below that set 4,5 FAQ separate them with Horizontal Divider 
when we tap on any of the FAQ then they just streach and showing the relevant answer
```

```
Slot6 -> Social Media Handle

this slot having "Still have a question? 'Get in touch' (single quoted text is textbutton with primary color and  when tap on that textButton then a new page or screen opens)" in the center.

"Get in touch screen
that screen having padding from left and right around 40,50

Header is same as the original one

Logo is displayed on the center of the screen with more padding from the top and less padding from bottom

below that "CONTACT" (having medium text and primary color) placed on  the left

below that "Get in touch" (having large , bold text with white color)

"Questions about the Flows, your account, licensing, or an idea you would like to share? Choose the route that fits best." (small text , not bold)

Horizontal Divider

In a row there are "EMAIL"  "devesh09269@gmail.com" having space between them
"FOLLOW"  "@deveshmishra_09"(link https://x.com/deveshmishra_09)
and having dividers

Footer section same as on the main page
```

```
Slot7 -> Footer

In a row there are three colomns 
Column 1
"PRODUCT" (this is the heading)
'Flows' (redirect me to the Flows slot)
'Pricing' (redirect me to the Pricing slot)
'FAQ' (redirect me to the FAQ slot)

Column 2
"CONNECT"
'Support' (for support checkout the website "https://www.withanimation.app/support" and build same just change the data)
'Contact' (redirect me to the get in touch screen)
'Follow on X' (redirect me to the X account link:- https://x.com/deveshmishra_09)

column 3
"LEGAL"
'Privacy' (build privacy screen same as the get it touch screen, same header , logo , footer just change the content for reference checkout "https://www.withanimation.app/privacy" shared website)
'Terms' (For terms checkout the website "https://www.withanimation.app/terms" and build") 



below that row 
there is another row with centered text
"© 2026 EnterpriseUIPlayground.app, Built with ❤️ by Devesh Mishra (@deveshmishra_09)"
@deveshmishra_09 is underlined & clickable and onClick redirect to the "https://x.com/deveshmishra_09"

```



# Guidelines
* use /askuserquestion tool to help me refine my idea in a more organised, structured and production ready deployment sense.
* Make seprate folder for documenting the whole planning in docs, markdown files, also create mermaid diagrams architecture for better understanding.
* implement the primary color in main.dart and use everywhere things which gonna use for several times so just write them ones and use them for many times.
* follow the structure for the folders.




# Constraints
* if something looks weird then stop and ask
* do not exaggerate the things and do not assume the things if something makes not sense then stop and ask about that thing. 
* I explain the things, layout and structure according to the web application but that is also for mobile and tablet means that web application having responsive UI regarding Desktop, mobile and tablet.


## Prompt-2
for background and logo

## Prompt-3
# Task
```
there are some task that you have to perform one by one

1. inside the flows there are subflows in these when we click and open any of the subflow then a screen opens which have a mobile emulator type which display the subflows on a mobile screen 
in that screen some of the subflows are not fit well so your task to find which flow not got fit on the mobile screen and then fix that issue.

2. on the subflow screen where the mobile screen shows there add a refresh button on top right corner bottom to the header which can refresh the flow to the initial screen.

3. i have implemented flows and subflow using grid view in web application so you notice that when i am navigating to any of the suflow then it directly redirect to the grid view for flow and subfloow in the mobile emulator screen
so remove those bad looking grid views. 

4. Your UI are looks well in mobile and tablet but when we are at at subflow or flow and then go back it just close the application did not go back step by step
```

# Guidelines 
```
* use /askuserquestion tool to help me refine my idea in a more organised, structured and production ready deployment sense.
```

# Constraints
* if something looks weird then stop and ask
* do not exaggerate the things and do not assume the things if something makes not sense then stop and ask about that thing. 
* I explain the things, layout and structure according to the web application but that is also for mobile and tablet means that web application having responsive UI regarding Desktop, mobile and tablet.

