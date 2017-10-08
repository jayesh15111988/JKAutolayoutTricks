# JKAutolayoutReadyScrollView


![alt text][UIScrollViewAutolayoutDemo]

<p>
A library to create ready-made and ready-to-plug in scrollview with autolayout constraints to stretch as per the content size.
This project born from my experince of how much painful it is to make UIScrollView work with autolayout seemlessly. It took me a while to fully understand how this is done and this library is the fruit of those efforts.

###Here's how to use this library :

First initialize the ```ScrollViewAutolayoutCreator``` with ```superview``` you are trying to integrate your ```UIScrollView``` into as follows,

```ScrollViewAutolayoutCreator* scrollViewAutoLayout = [[ScrollViewAutolayoutCreator alloc] initWithSuperView:superView];```

This line assumes that you are going to put all your ```UIScrollView``` content in the ```superView```. You don't have to worry about putting ```contentView``` inside your ```superView```. Library will take care of it.

Once initialization is done, get hold of ```contentView``` from library as follows :  ```scrollViewAutoLayout.contentView.``` 

Now all the view, label or input fields you are going to add, add them to this ```contentView``` with regular auto layout constraints.

Since requirement of UIScrollView autolayout suggets that bottom most view's bottom should be constrained to the bottom of superview (with padding if required as dictated by user) it is added in, we will have to add bottom constraint to the vertically last view added to the contentView. (Remember, ```contentView``` this is the view you need to add your all subviews to). However, you need not add the last constraint by yourself. Library will do that. 

Just call following instance method with vertically last view as a parameter and required amount of bottom padding. Autolayout will take care of everything else.

```[scrollViewAutoLayout addBottomSpaceConstraintToLastView:lastView withBottomPadding:bottomPaddingValue];```

And that's it. It is done. You don't even need to add contentView to the ```superView```, as mentioned earlier, it is all done by the library when you intialize it with a ```superView```.

>Note : This library uses TPKeyboardAvoidingScrollView which is useful for avoiding >keyboard while typing in the UITextField, UITextView or any relevant input field which >accepts input characters. This is done automatically behind the curtains so that you do not have to worry about it.

<b>If you face any difficuly integrating this library, you can always refer to the example added to the project. If that is not enough, do not hesitate to contact me on the email address. </b>

<i>Any comments, suggestions, critics, feedback is always welcome. If you can add an improvements to this library, feel free to send a pull request.

Cheers</i>

[UIScrollViewAutolayoutDemo]: https://github.com/jayesh15111988/JKAutolayoutReadyScrollView/blob/master/Demo/Autolayout_Demo.gif "UIScrollView - Autolayout Demo"
