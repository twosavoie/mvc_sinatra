This app works correctly in Chrome, Firefox, & Opera. Safari is different. It doesn't automatically create a datepicker from <input date>. In Safari, just numbers is understood as yyyymmdd, dashes and slashes as ddmmyyyy. I havent' figured out a way to keep it working in other browsers and parse the input from Safari into the correct format. 

A problem for another day.

This is a Ruby app using Sinatra and ActiveRecord
This is the flow:

Entering the url brings up the **layout.erb** page rendering the HTML and CSS. The body has a *yield* to allow the **form.erb** to appear. The user enters their birthdate going to the **index.erb** (message/:id). They receive their message that has been determined by the **person.rb** script. That's the end of this part of the app. The **index_controller.rb** includes the get and post methods for this part of the app.

Entering the url/person/new takes you to the create person page. **layout.erb** renders the HTML and CSS. **new.erb** routes to the **_form.erb** to render the form to create a new person. The user completes the form, hits submit and is routed to **people/show.erb**. They receive their message as determined by the **person.rb** script and an informational paragraph. The data entered by the user through **_form.erb** is added to the database **people/index.erb**. This database is a table, formatted through Bootstrap CSS, that includes first and last names, birthdates, an edit link and a delete button.

Clicking edit the user is routed through **people/edit.erb** to **_form.erb** which renders a form to edit the database. Entering data the user is routed to **people/show.erb**. They receive their message as determined by the **person.rb** script and an informational paragraph. The data entered by the user through **_form.erb** is added to the database **people/index.erb**. This database is a table, formatted through Bootstrap CSS, that includes first and last names, birthdates, an edit link and a delete button.

The **application_helper.rb** contains the methods that determine if the form in **people/_form.erb** is the Create people or Edit people form.

The **people_controller.rb** includes the get, post, put, and delete methods for the Create and Edit pages.
