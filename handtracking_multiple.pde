import SimpleOpenNI.*;
SimpleOpenNI  kinect;
void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  // turn on user tracking
  kinect.enableUser();
}
void draw() {
  kinect.update();
  PImage depth = kinect.depthImage();
  image(depth, 0, 0);
  // make a vector of ints to store the list of users
  IntVector userList = new IntVector();
  // write the list of detected users
  // into our vector
  kinect.getUsers(userList);
  // if we found any users
 
  for (int i = 0; i < userList.size(); i = i+1) {
  

    if (userList.size() > 0) {
      // get the first user
      int userId = userList.get(i);
      // if we’re successfully calibrated
      if ( kinect.isTrackingSkeleton(userId)) {
        // make a vector to store the left hand
        PVector rightHand = new PVector();
        // put the position of the left hand into that vector
        float confidence = kinect.getJointPositionSkeleton(userId, 
        SimpleOpenNI.SKEL_LEFT_HAND, 
        rightHand);
        // convert the detected hand position
        // to "projective" coordinates
        // that will match the depth image
        PVector convertedRightHand = new PVector();
        kinect.convertRealWorldToProjective(rightHand, convertedRightHand);
        // and display it
        fill(255, 0, 0);
        ellipse(convertedRightHand.x, convertedRightHand.y, 10, 10);
        
         // make a vector to store the left hand
        PVector leftHand = new PVector();
        // put the position of the left hand into that vector
        float confidencej = kinect.getJointPositionSkeleton(userId, 
        SimpleOpenNI.SKEL_RIGHT_HAND, 
        leftHand);
        // convert the detected hand position
        // to "projective" coordinates
        // that will match the depth image
        PVector convertedLeftHand = new PVector();
        kinect.convertRealWorldToProjective(leftHand, convertedLeftHand);
        // and display it
        fill(255, 0, 0);
        ellipse(convertedLeftHand.x, convertedLeftHand.y, 10, 10);
      }
    }
  }
}
void onNewUser(SimpleOpenNI curContext,int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
   
  kinect.startTrackingSkeleton(userId);
}
 
void onLostUser(SimpleOpenNI curContext,int userId)
{
  println("onLostUser - userId: " + userId);
}
 
void onVisibleUser(SimpleOpenNI curContext,int userId)
{
  //println("onVisibleUser - userId: " + userId);
}
