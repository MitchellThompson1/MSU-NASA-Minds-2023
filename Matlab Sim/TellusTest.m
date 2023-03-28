%Number of steps between points
numSteps = 10;
numBots = 3;

%Create Robots and put them at starting points
tellus1 = rectangle( 'Parent', gca, 'Position', [5.3,3, .3, .3], 'Curvature', [1 1] );
tellus2 = rectangle( 'Parent', gca, 'Position', [-3,5, .3, .3], 'Curvature', [1 1] );
tellus3 = rectangle( 'Parent', gca, 'Position', [-5,-3, .3, .3], 'Curvature', [1 1] );
botArray = [tellus1, tellus2, tellus3];

% For every chunk:
    % Pick a chunk
    % Generate Path Through it
    % Accumulate distance of path
    % Pick another Chunk
clc
%Checkerboard Scanning Setup
%How big in meters is the field length
FieldLength = 10;

%How many squares shall the field be divided in?
chunkSize = numBots;

%Center Coordingate and Chunk Length
centerCoord = [0,0];
chunkLen = FieldLength/chunkSize;

%How fine of a grid (Powers of 2 only)
granularity = 4; 

%Map creation
chunk = Chunk(FieldLength,FieldLength,chunkSize,centerCoord);

%Robot Scanning Radius
r = 0.25;

%Display the chunks
A = cell2mat(chunk);
x = A(1:2:end);
y = A(2:2:end);

%Setup Simulation
figure; axis square; 
scatter(x, y);
set(gca,'XLim',[-(FieldLength/2) FieldLength/2], 'YLim', [-FieldLength/2 FieldLength/2]);

startPoints = chunk(1:4:end);

%Set Field Status Array 
fieldStatus = repelem(false, chunkSize*chunkSize);
fieldIndex = 1;

%Precalculated Circle 
th = 0:pi/50:2*pi;
x_circle = r * cos(th);
y_circle = r * sin(th);

while sum(fieldStatus) ~= chunkSize*chunkSize
    path = GeneratePath(startPoints{fieldIndex}, chunkLen, chunkLen/granularity, 0);

    %Iterate through all of the points on the path 
    for i = 1:2:length(path)-2 
        x = [path(i) path(i+2)];
        y = [path(i+1) path(i+3)];

        % Calculate the trajectory of Each Bot by linear interpolation of the x and y coordinate.
        trajectory = [linspace(x(1),x(2),numSteps); linspace(y(1),y(2),numSteps)];
        % Make figure with axes.

        % Draw All the Bots
        for frameNr = 1 : numSteps
            for j = 1 : numBots
                set(botArray(j), 'Position', [trajectory(1,frameNr), trajectory(2,frameNr), .3, .3]);
                hold on
                xc_temp = x_circle + trajectory(1,frameNr);
                yc_temp = y_circle + trajectory(2,frameNr);
                circles = plot(xc_temp, yc_temp);   
                fill(xc_temp, yc_temp, "b")
                hold off
            end
   
          frames(frameNr) = getframe;
        end
    end
    
    %Increment the Field Status
    fieldStatus(fieldIndex) = true;

    %Choose Next Field Index 
    currentPoint = [x(2), y(2)];
    distances = [];
    for i =1:length(fieldStatus)
        dist = inf;
        if (fieldStatus(i) == false)
            dist = norm(currentPoint - startPoints{i});
        end
        distances = [distances, dist];
        [Min, MinIndex] = min(distances);
    end
    fieldIndex = MinIndex;
    
    %Travel To Next Starting Point
    x = [x(2) startPoints{fieldIndex}(1)];
    y = [y(2) startPoints{fieldIndex}(2)];
    trajectory = [linspace(x(1),x(2),numSteps); linspace(y(1),y(2),numSteps)];
    
    % Draw the bots
    for frameNr = 1 : numSteps
        for j = 1 : numBots
            set(botArray(j), 'Position', [trajectory(1,frameNr), trajectory(2,frameNr), .3, .3]);
            hold on
            xc_temp = x_circle + trajectory(1,frameNr);
            yc_temp = y_circle + trajectory(2,frameNr);
            circles = plot(xc_temp, yc_temp);   
            fill(xc_temp, yc_temp, "b")
            hold off
        end
      frames(frameNr) = getframe;
    end

end

% function CoopMappingAlgorithmStep()
%     if sectorComlete 
%         if AllSectorsCovered
%             %Go Home
%         else
%             %Pick Closest Non-Active Square
%             %Generate Target List and Reset Index 
%         end
%     else
%         %Collect Data
%         %Calculate Displacement
%     end
% end











