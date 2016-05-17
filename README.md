# Bull's Eye Extension

##Goals
If you're reading this, you should have already completed Tutorial 1 of Ray Wenderlich's iOS Apprentice (Beginning iOS Development with Swift 2). By following that tutorial, you were introduced to Swift and UIKit through creating a simple iOS number guessing game. In this extension, you're going to add some complexity to the game by introducing more complicated math, creating additional functions, and building more UI features.

##Instructions

This is roughly what the app will look like when you're done:

![Finished app](http://i.imgur.com/vNhhXnm.png "Finished app")

You will be adding another `UISlider` and a `UILabel` to the app. Each `UISlider` should have a randomized minimum value and maximum value. The `UILabel` will contain a random mathematical operation in it (`+`, `-`, `x`, or `÷`). The player must select a value from each of the sliders so that when the two numbers are combined using the operator, they are equal to the target value.

###1. Creating the new UI

First, create a UILabel for the operation. Let's keep it simple at first - the label should always have a `+` sign in it. Create an `IBOutlet` for this label in your `ViewController.swift`.

Next, create a new `UISlider` and place it below the "operation" label. Connect this second slider to your `ViewController.swift` and make sure everything is still working. For the time being, let's keep the range of this slider as 0-100 - the same as the original slider.

Try to constrain both of these new elements so that they are laid out like the above picture.


###2. Updating the game

Now that you have the extra UI elements set up, you should be ready to update the scoring for the game. You'll need to grab the values from both of the sliders and make sure that their sum is equal to the randomly generated target number. Feel free to update the criteria for scoring as you see fit. You can also update the range for the randomly generated target number to 2-200 since we're now checking a sum instead of a single number.

###3. More randomness!

Let's change up the ranges for each of the sliders. The minimum value for the first slider should be a random number between 1 and 50, and the maximum value should be a random number between 50 and 100. Do the same for the second slider (note that you should come up with 2 new random numbers for the second slider - do not use the same numbers as you used for the first slider).

You should also generate an operator to be displayed in the label - randomly select `+`, `-`, `x`, or `÷`. 

You might be realizing a problem with the app at this point. We can't jsut randomly generate a number from 1-100 for the target number anymore since there's a chance that the operation involving the 2 numbers from the sliders can't be equal to a value between 0-100. What sort of math can you do to make sure that the target number is a value that can be reached from the sliders?

That's it! Bask in the glory of your newly updated Bull's Eye app.