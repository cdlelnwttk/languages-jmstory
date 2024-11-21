% Dynamic declaration to store user preferences
:- dynamic likes/2.

% Facts about movies and their attributes
movie('The Dark Knight', [action, drama, modern, nolan]).
movie('Inception', [action, drama, modern, nolan]).
movie('Memento', [drama, modern, nolan, action]).
movie('Some Like it Hot', [romance, comedy, classic]).
movie('Titanic', [romance, middle, cameron]).
movie('True Lies', [action, romance, middle, cameron]).
movie('Avatar', [action, modern, cameron]).
movie('Terminator 2: Judgement Day', [action, middle, cameron]).
movie('Psycho', [horror, classic, hitchcock]).
movie('Vertigo', [drama, classic, hitchcock]).
movie('The Birds', [horror, classic, hitchcock]).
movie('Casablanca', [drama, romance, classic]).
movie('Rosemarys Baby', [horror, classic]).
movie('Rocky', [action, drama, middle]).
movie('The Matrix', [romance, action, middle]).
movie('The Godfather', [drama, action, middle]).
movie('Eternal Sunshine of the Spotless Mind', [romance, drama, modern]).
movie('Lost in Translation', [romance, comedy, modern]).
movie('Breakfast at Tiffanys', [romance, comedy, classic]).
movie('When Hary Met Sally', [romance, comedy, middle]).

ask_movie(Movie) :-
    movie(Movie, Attributes),
    write('Do you like the movie: '), write(Movie), write('? (yes/no): '),
    read(Response),
    nl,  % This consumes the newline character
    (   Response == yes -> assert_likes_attributes(Attributes);
        Response == no -> true;
        write('Invalid input. Please respond with yes or no.'), nl).

% Store and increment the count for each attribute that the user likes
assert_likes_attributes(Attributes) :-
    foreach(member(Attribute, Attributes), update_like_count(Attribute)).

% Update the count for the attribute: if the attribute is already liked, increment its count
update_like_count(Attribute) :-
    (   likes(Attribute, Count)  % If the attribute is already in the list
    ->  NewCount is Count + 1,        % Increment the count
        retract(likes(Attribute, Count)),  % Remove the old count
        assert(likes(Attribute, NewCount))  % Add the new count
    ;   assert(likes(Attribute, 1))  % If not in the list, add it with count 1
    ).

% Print all the user likes facts
print_likes :-
    findall(likes(Attribute, Count), likes(Attribute, Count), LikesList),
    print_likes_list(LikesList).

% Helper predicate to print each fact
print_likes_list([]). % Base case: empty list
print_likes_list([likes(Attribute, Count) | Rest]) :- 
    format('likes(~w, ~w).~n', [Attribute, Count]),
    print_likes_list(Rest).

% Find the highest count of liked attributes
find_max_likes(MaxCount) :-
    findall(Count, likes(_, Count), Counts),  % Collect all counts
    (   Counts == []                          % If no likes exist
    ->  MaxCount = 0                          % Set MaxCount to 0 if the list is empty
    ;   max_list(Counts, MaxCount)            % Otherwise, find the maximum count
    ).

% Print all attributes with the greatest number of likes
print_most_liked :-
    find_max_likes(MaxCount),                              % Get the highest count
    (   MaxCount == 0                                     % If there are no likes (MaxCount is 0)
    ->  write('No likes recorded yet.'), nl
    ;   findall(Attribute, likes(Attribute, MaxCount), Attributes),  % Find all attributes with the max count
        print_attributes(Attributes)                             % Print those attributes
    ).

% Helper function to print each attribute
print_attributes([]).
print_attributes([Attribute | Rest]) :-
    write(Attribute), nl,                      % Print the attribute
    print_attributes(Rest).

% Main logic to handle ties or no likes
handle_likes :-
    find_max_likes(MaxCount),                              % Get the highest count
    (   MaxCount == 0                                        % If no likes are present (MaxCount is 0)
    ->  tieMenu,                                            % Call tieMenu to handle the no likes case
        write('No likes recorded yet.'), nl
    ;   findall(Attribute, likes(Attribute, MaxCount), Attributes),  % Find all attributes with the max count
        length(Attributes, NumAttributes),                     % Get the number of attributes with the max count
        (   NumAttributes > 1                                   % If there are ties (multiple attributes with the max count)
        ->  tieMenu,                                            % Call tieMenu function to handle ties
            write('There is a tie in your likes! Displaying movies for tied attributes:'), nl
        ;   write('The most liked attribute is: '), write(MaxCount), nl    % If there is no tie, display the most liked attribute
        )
    ).

% Function to handle ties and print a unique list of movies based on tied attributes
tieMenu :-
    write('Movies for tied attributes: '), nl.


% Main rule to start the program
start :-
    retractall(likes(_, _)), % Clear the likes list at the start
    ask_movie('The Dark Knight'),
    ask_movie('Inception'),
    ask_movie('When Harry Met Sally'),
    ask_movie('Terminator 2: Judgement Day'),
    ask_movie('Titanic'),
    ask_movie('Casablanca'),
    ask_movie('The Matrix'),
    ask_movie('The Godfather'),
    ask_movie('Pulp Fiction'),
    ask_movie('The Shawshank Redemption'),
    handle_likes.  % Call handle_likes to process the most liked attributes




















