# ASMIO-App
E-commerce related application

## Use

### **Structure**:-

I used the MVVM structure with use cases to cleanly achieve separation of concern for the user interface from the application logic. By using this architecture it helped in
- Independent of UI: The UI can change easily, without changing the rest of the system as we can substitute the table view with a collection view and we will not have to touch our logic
- Independent of the database and network: I can easily change them without breaking business rules.
- Testable: The business rules can be tested without the UI, database, web server, or any other external element.

#### Data Flow
1. View(UI) calls a method from ViewModel.
2. ViewModel executes Use Case.
3. Use Case call network API and return the articles to viewModel.
5. Information flows back to the View(UI) where we display the list of items.

### **Enums**:-

Using enum is very pretty as I can set the cases and extend these cases with variables, I used them in
- Managing view states 
- Listing differrent categories and countries 
- Build Alamofire network request

## Pods

- **Alamofire**: HTTP networking library to simplify common REST services.
- **SDWebImage**: Async image downloader with cache support.
- **Cosmos**:  Shows a star rating and takes rating input from the user.

## ScreenShots

<div>
<img src = "https://user-images.githubusercontent.com/17858852/157211172-a144e5bc-c1e6-4150-9b91-5c6ab3521c90.png" width= "100">
<img src = "https://user-images.githubusercontent.com/17858852/157211226-b9b57223-346e-40d6-9a06-9c760fa63330.png" width= "100">
<img src = "https://user-images.githubusercontent.com/17858852/157211205-72ac636e-7497-4198-b4af-102c83b8cde7.png" width= "100">
<img src = "https://user-images.githubusercontent.com/17858852/157211247-6c032722-2163-4c7c-97cd-ebd294e921bd.png" width= "100">
<img src = "https://user-images.githubusercontent.com/17858852/157211270-8c230b53-fa22-4f27-821e-045254fcd5cb.png" width= "100">
<img src = "https://user-images.githubusercontent.com/17858852/157211306-6e548301-949e-454c-ae9f-fb85de1b4041.png" width= "100">
</div>

## Video

https://user-images.githubusercontent.com/17858852/157212395-97539edf-b0b9-41de-95b3-cb82bcb59832.mp4

