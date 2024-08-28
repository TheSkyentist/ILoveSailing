# Simple Sailing Model

## How To Run
1) Download Love (maybe with homebrew)
2) Clone this repo
3) Navigate to this directory
4) Call ```love .```
5) Sail

## Display
The Boat is the white quadrilateral. Its direction determines the keel direction. The sail is the black line on the boat. The green line coming from the bow of the vessel is the current velocity. The black lines in the bottom right corner are the accelerations acting on the boat. The white line is the net acceleration. In the top left corner, the cyan is the water velocity and the green is the wind. 

## Control
Left and right arrow control hull direction (e.g. rudder).
Up and down control the sail (sort of a main sheet). Turning the hull will turn the sail with it (like a real boat). 

## Change Physical constants
All physical numbers that you can play with are stored in the main.lua file. 

## Implementation
All fields are scalar/vector fields, but are currently static for now. 

## Notes
1) If you make the mass too low or the velocities too high, the boat's instantaneous acceleration can make it go faster than the wind, making the drag force even stronger, which blows up exponentially. 
2) Since this is graphics, (0,0) is the top left corner, and an angle of 0 is defined as straight up. 
3) This is pacman world, you wrap around. 