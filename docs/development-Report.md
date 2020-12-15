# AskIt

Team members:

<ul>
  <li>Fabio Moreira </li>
  <li>Luís Afonso  </li>
  <li>João Cunha </li>
  <li>Pedro Coelho </li>
  <li>José Maçães </li>
 </ul>

## Product Vision

AskIt, a platform to manage the very limited time to ask questions at the end of the lecture, ensuring the best ones get answered first.

## Elevator Pitch

Conference attendees often feel frustrated by the lack of quality of questions taking up the very limited time at the end.
AskIt optimizes everyone's experience by allowing all the attendees to vote on the best questions, leading to a better use of the time.
From now on you can attend any conference knowing that only the most pertinent questions will be asked, leading to more intriguing discussions.

## Requirements

### Use case diagram

![use case diagram](./images/use_case_diagram.png 'Use Case Diagram')

#### AskIt

**Actor**: Atendee  
**Description**: User can post questions regarding the lecture he is attending. He can also mark the number of the slide relevant to his question.  
**Normal Flow**: The user writes a question, selects the slide number and then submits the question.

#### See Slides

**Actor**: Atendee  
**Description**: User can download the presentation if it has been made available by the speaker.  
**Normal Flow**: User downloads the presentation file.

#### Rate Questions

**Actor**: Atendee  
**Description**: User sees all questions in a list and may choose to rate any question.  
**Normal Flow**: User scrolls through the list and votes on the questions he desires.

#### Submit Presentation

**Actor**: Speaker  
**Description**: User may choose a file from his device and upload it into the app.  
**Normal Flow**: User presses upload lecture, and navigates through his device to select the file to upload.

#### See Questions

**Actor**: Speaker  
**Description**: User sees the list of questions ordered by their current rating.  
**Normal Flow**: User can scroll through the list of submitted questions.

#### Answer Questions Post Lecture

**Actor**: Speaker  
**Description**: After the lecture has ended, the user may submit an answer to questions that there was no time for.  
**Normal Flow**: User selects one question and may submit an answer.

### User stories

### - User story #01(Login):

As a user, I want to log into the app.

#### User interface mockup

<img src="./images/UserStory01.png" height="400" alt="User Story 01 Mockup">

#### Acceptance tests

```gherkin
  Scenario:
  Given There are fields for user to input email and password
  When User fills those fields
  And The information is correct
  Then The user is logged in
```

```gherkin
  Scenario:
  Given There are fields for user to input email and password
  When User fills those fields
  And The information is incorrect
  Then The user is not logged in
```

#### Value and effort

Value: Must have

Effort: M

### - User story #02(See My Lectures):

As a user, I want to filter and view lectures that I have attended or will attend.

#### User interface mockup

<img src="./images/UserStory02.png" height="400" alt="User Story 02 Mockup">

#### Acceptance tests

```gherkin
  Scenario:
  Given A list of lectures associated with the user
  When User selects the "lecturer" filter
  Then Only lectures where user was the lecturer are displayed
```

```gherkin
  Scenario:
  Given A list of lectures associated with the user
  When User selects the "attendee" filter
  Then Only lectures where user was an attendee are displayed
```

```gherkin
  Scenario:
  Given A list of lectures associated with the user
  When User selects the "upcoming" filter
  Then Only lectures that will be happening in the future are displayed
```

```gherkin
  Scenario:
  Given A list of lectures associated with the user
  When User selects the "previous" filter
  Then Only lectures that already happened will be displayed
```

#### Value and effort

Value: Must have

Effort: S

### - User story #03(Create Lecture):

As a lecturer, I can create a new lecture

#### User interface mockup

<img src="./images/UserStory03.png" height="400" alt="User Story 03 Mockup">

#### Acceptance tests

```gherkin
  Scenario:
  Given The form for creating a new lecture
  When User fills all the fields
  Then A new lecture is created and added to the user's lectures list with role "Lecturer"
```

```gherkin
  Scenario:
  Given The form for creating a new lecture
  When User selects a date in the past
  Then The creation process fails and an error message is displayed

```

#### Value and effort

Value: Must have

Effort: L

### - User story #04(Choose lecture to attend):

As a user, I want to be able to see upcoming lectures (w/ filters) and choose one to attend.

#### User interface mockup

<img src="./images/UserStory04.png" height="400" alt="User Story 04 Mockup">

#### Acceptance tests

```gherkin
  Scenario:
  Given A list of the upcoming lectures
  When User presses the lecture they want to attend
  And They press the "Join" button
  Then Lecture is added to the lectures list of the user with role "Attendee"
```

```gherkin
  Scenario:
  Given A list of the upcoming lectures
  When User selects a lecture that is already at maximum capacity
  Then Message is displayed to the user letting them know lecture is full
```

#### Value and effort

Value: Must have

Effort: L

### - User story #05(Update Status of Presentation):

As a lecturer, I can change the status of my presentation (Live/Finished)

#### User interface mockup

<img src="./images/UserStory05.png" height="400" alt="User Story 05 Mockup">

#### Acceptance tests

```gherkin
  Scenario:
  Given The options regarding the status of the lecture
  When The current status is "Not started yet"
  And User presses "Live"
  Then The status should change to "Live"

```

```gherkin
  Scenario:
  Given The options regarding the status of the lecture
  When The current status is "Live"
  And User presses "Finished"
  Then The status should change to "Finished"
```

```gherkin
  Scenario:
  Given The options regarding the status of the lecture
  When The current status is "Live"
  And User presses "Not started yet"
  Then The status should not change
  And An error message should be displayed

```

```gherkin
  Scenario:
  Given The options regarding the status of the lecture
  When The current status is "Finished"
  And User presses any other state
  Then The status should not change
  And An error message should be displayed
```

#### Value and effort

Value: Should have

Effort: M

### - User story #06(Submit Presentation):

As a lecturer I can submit my presentation so that attendees can follow along my presentation.

#### User interface mockup

<img src="./images/UserStory06.png" height="400" alt="User Story 06 Mockup">

#### Acceptance tests

```gherkin
  Scenario:
  Given Lecturer is on the page of the Lecture
  When Lecturer presses the "Select File" button
  And Chooses a file
  Then The file should be uploaded

```

#### Value and effort

Value: Must have

Effort: S

### - User story #07(Download Presentation):

As an attendee, I can access the slides submitted by the lecturer to follow along

#### User interface mockup

<img src="./images/UserStory07.png" height="400" alt="User Story 07 Mockup">

#### Acceptance tests

| Id  | Given                                    | When                                                                      | Then                                                      |
| --- | ---------------------------------------- | ------------------------------------------------------------------------- | --------------------------------------------------------- |
| 16  | Lecturer submitted slides                | The user is on the lecture page **AND** User presses the name of the file | The presentation file should open                         |
| 17  | Lecturer did not submit the presentation | The user is on the lecture page                                           | Message should be displayed that slides are not available |

#### Value and effort

Value: Must have

Effort: S

### - User story #08(Select Slide Number):

As a user I can select which slide I have a doubt so that it is easier for the lecturer to answer my question.

#### User interface mockup

<img src="./images/UserStory08.png" height="400" alt="User Story 08 Mockup">

#### Acceptance tests

| Id  | Given                                           | When                                                                 | Then                                                                             |
| --- | ----------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| 18  | User is in the process of submitting a question | The user selects the slide number of the question **AND** submits it | The question description should have the correct slide number associated with it |

#### Value and effort

Value: Must have

Effort: M

### - User story #09(Vote on Questions):

As a user, I can vote on which questions I like the most so that they are more likely to get answered.

#### User interface mockup

<img src="./images/UserStory09.png" height="400" alt="User Story 09 Mockup">

#### Acceptance tests

| Id  | Given                                                                                                                     | When                                               | Then                                    |
| --- | ------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------- |
| 19  | User is in the questions page of a lecture **AND** questions were submitted                                               | User presses the _up_ arrow next to the question   | The rating should be incremented by one |
| 20  | User is in the questions page of a lecture **AND** questions were submitted **AND** User already pressed the _up_ arrow   | User presses the _up_ arrow next to the question   | The rating should stay the same         |
| 21  | User is in the questions page of a lecture **AND** questions were submitted **AND** User already pressed the _up_ arrow   | User presses the _down_ arrow next to the question | The rating should be decreased by 2     |
| 22  | User is in the questions page of a lecture **AND** questions were submitted                                               | User presses the _down_ arrow next to the question | The rating should be decreased by one   |
| 23  | User is in the questions page of a lecture **AND** questions were submitted **AND** User already pressed the _down_ arrow | User presses the _down_ arrow next to the question | The rating should stay the same         |
| 24  | User is in the questions page of a lecture **AND** questions were submitted **AND** User already pressed the _down_ arrow | User presses the _up_ arrow next to the question   | The rating should be increased by 2     |

#### Value and effort

Value: Must have

Effort: M

### - User story #10(See Questions Sorted by Rating):

As a lecturer I can look at the highest rated questions so that I can answer the most wanted questions first.

#### User interface mockup

<img src="./images/UserStory10.png" height="400" alt="User Story 10 Mockup">

#### Acceptance tests

| Id  | Given                                    | When                                                             | Then                                                               |
| --- | ---------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------ |
| 25  | Lecturer is on the "Manage Lecture" page | Lecturer presses "View Questions" **AND** questions exist        | Questions should be displayed sorted by rating                     |
| 26  | Lecturer is on the "Manage Lecture" page | Lecturer presses "View Questions" **AND** questions do not exist | A message should be displayed alerting that there are no questions |

#### Value and effort

Value: Must have

Effort: M

### - User story #11(Reply to Questions post Lecture):

As a user I can reply to other user's questions after the lecture has ended so that more questions can get answered.

#### User interface mockup

<img src="./images/UserStory11.png" height="400" alt="User Story 11 Mockup">

#### Acceptance tests

| Id  | Given                                                                       | When                                  | Then                                                 |
| --- | --------------------------------------------------------------------------- | ------------------------------------- | ---------------------------------------------------- |
| 27  | User pressed in one of the questions present in the lecture's question list | User presses "Reply to this question" | User should be able to write their reply and post it |

#### Value and effort

Value: Should have

Effort: L

### - User story #12(Sort Questions):

As a user, I want to sort the existent questions by rating or by new.

#### User interface mockup

<img src="./images/UserStory12.png" height="400" alt="User Story 12 Mockup">

#### Acceptance tests

| Id  | Given                                                          | When                             | Then                                                 |
| --- | -------------------------------------------------------------- | -------------------------------- | ---------------------------------------------------- |
| 28  | User is in the lecture's question page **AND** questions exist | User selects the "New" filter    | Recent questions should appear first                 |
| 29  | User is in the lecture's question page **AND** questions exist | User selects the "Rating" filter | Questions with the highest score should appear first |

#### Value and effort

Value: Could have

Effort: M

### User story map

<img src="./images/storyMap.jpg" >

### Domain model

<img src="./images/problem_domain_uml.png" height="320" alt="Problem Domain UML">

## Architecture and Design

The architecture of a software system encompasses the set of key decisions about its overall organization.

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them.

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture

The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:

horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts;
vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture

<img src="./images/component_diagram_uml.png" height="210" alt="Component Diagram UML">
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

### Prototype

To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

## Implementation

Regular product increments are a good practice of product management.

While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

### Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:

test plan describing the list of features to be tested and the testing methods and tools;
test case specifications to verify the functionalities, using unit tests and acceptance tests.
A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the GitHub flow.

## Project management

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Example of tools to do this are:

Trello.com
Github Projects
Pivotal Tracker
Jira
We recommend to use the simplest tool that can possibly work for the team.
