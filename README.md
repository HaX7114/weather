# Weather app
![App](https://user-images.githubusercontent.com/62621180/189498333-798d7891-5496-4a5f-9fea-23acf53583bc.png)


## Flutter Weather App With Adaptive Time UI and Animations 
## Using Open Weather API as Remote and Shared Preferences as local

## App Video Preview :


https://user-images.githubusercontent.com/62621180/189497310-de2654f3-459f-4f3f-8613-5a5d9700c414.mp4

## How App Works ?
## First of all the app is trying to get the location data (Lat | Lon) by showing this :

![Screenshot_2022-09-11-17-52-29-12_067ca54d029a1c65bea8d27590265e45](https://user-images.githubusercontent.com/62621180/189523267-24f08214-a3cf-4103-b362-814034fe45bd.jpg)

## Some cases may happen when the application is trying to get the location data like these cases :
## Case 1: 

### when the user is not enabled the location services the app shows this :

![Screenshot_2022-09-11-11-50-41-03_067ca54d029a1c65bea8d27590265e45](https://user-images.githubusercontent.com/62621180/189522971-b9fb9f86-85b6-4da5-8fb9-103509ac1f00.jpg)

## Case 2: 
### when the user denied to grant the location services permission the app shows this :

![Screenshot_2022-09-11-11-51-11-11_067ca54d029a1c65bea8d27590265e45](https://user-images.githubusercontent.com/62621180/189523067-89a113ab-aa2f-4a4f-8431-7247a0eb0338.jpg)


## Case 3: 
### when the user is not enabled the internet data services the app shows this :

![Screenshot_2022-09-11-11-51-58-80_067ca54d029a1c65bea8d27590265e45](https://user-images.githubusercontent.com/62621180/189523099-5e98701f-5540-459a-986f-a6a98ea1b0ce.jpg)

## Case 4: 
### when the user is enabled the location services,granted the permission and enabled the internet data the app shows this :

### 1-Getting Weather Data:

![Screenshot_2022-09-11-17-54-48-66](https://user-images.githubusercontent.com/62621180/189523227-319d9cd2-b580-4dcd-b171-ff46fe8af548.jpg)


### 2-Show The Data:

![Screenshot_2022-09-10-17-00-23-04_067ca54d029a1c65bea8d27590265e45](https://user-images.githubusercontent.com/62621180/189523222-994dc8ea-1d68-4511-be75-f1761184f302.jpg)




## App Dependencies :
## cupertino_icons: ^1.0.2
## google_fonts: ^3.0.1
## fluttertoast: ^8.0.9
## page_transition: ^2.0.9
## lottie: ^1.4.1
## animate_do: ^2.1.0
## geolocator: ^9.0.1
## bloc: ^8.1.0
## flutter_bloc: ^8.1.1
## dio: ^4.0.6
## conditional_builder_null_safety: ^0.0.6
## loading_animation_widget: ^1.2.0+2
## flutter_phoenix: ^1.1.0
## intl: ^0.17.0
## shared_preferences: ^2.0.15


