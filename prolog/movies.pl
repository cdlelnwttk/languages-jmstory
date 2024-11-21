% Dynamic declaration to store user preferences
:- dynamic likes/2.

% Facts about movies and their attributes
movie('The Dark Knight', [action, modern, nolan]).
movie('Inception', [action, modern, nolan]).
movie('Memento', [drama, middle, nolan, action]).
movie('Some Like it Hot', [romance, comedy, classic]).
movie('Psycho', [horror, classic, hitchcock]).
movie('Vertigo', [drama, classic, hitchcock]).
movie('Casablanca', [drama, romance, classic]).
movie('Rosemarys Baby', [horror, classic]).
movie('The Matrix', [romance, action, middle]).
movie('The Godfather', [drama, action, middle]).
movie('Eternal Sunshine of the Spotless Mind', [romance, drama, modern]).
movie('Lost in Translation', [romance, comedy, modern]).
movie('Breakfast at Tiffanys', [romance, comedy, classic]).
movie('When Harry Met Sally', [romance, comedy, middle]).

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
find_max_likes(MaxCount, MostLikedAttributes) :-
    findall(Count, likes(_, Count), Counts),  % Collect all counts
    (   Counts == []                          % If no likes exist
    ->  MaxCount = 0,                         % Set MaxCount to 0 if the list is empty
        MostLikedAttributes = []              % Set MostLikedAttributes to an empty list
    ;   max_list(Counts, MaxCount),           % Find the maximum count
        findall(Attribute, likes(Attribute, MaxCount), MostLikedAttributes) % Collect all attributes with the max count
    ).

% Print all attributes with the greatest number of likes
print_most_liked :-
    find_max_likes(MaxCount, MostLikedAttributes), % Get the highest count
    (   MaxCount == 0                                     % If there are no likes (MaxCount is 0)
    ->  write('No likes recorded yet.'), nl
    ;   print_attributes(MostLikedAttributes)                             % Print those attributes
    ).

% Helper function to print each attribute
print_attributes([]).
print_attributes([Attribute | Rest]) :- 
    write(Attribute), nl,                      % Print the attribute
    print_attributes(Rest).


% Main logic to handle ties or no likes
handle_likes :-
    find_max_likes(MaxCount, MostLikedAttributes), % Get the highest count
    (   MaxCount == 0                                        % If no likes are present (MaxCount is 0)
    ->  tieMenu,                                            % Call tieMenu to handle the no likes case
        write('No likes recorded yet.'), nl
    ;   length(MostLikedAttributes, NumAttributes),        % Get the number of attributes with the max count
        (   NumAttributes > 1                                   % If there are ties (multiple attributes with the max count)
        ->                                            % Call tieMenu function to handle ties
            tieMenu(MostLikedAttributes)
        ;   MostLikedAttributes = [Head | _],                  % Extract the first attribute (Head)
            write('The most liked attribute is: '), write(Head), nl,
            handle_specific_attribute(Head)                    % Handle the specific attribute
        )
    ).

% Function to handle ties and print a unique list of movies based on tied attributes
tieMenu :-
    write('Pick the movie you like out of these the best'), nl,
    write('1: 13 Going on 30'), nl,
    write('2: Star Wars: A New Hope'), nl,
    write('3: A Beautiful Mind'), nl,
    write('4: Halloween'), nl,
    write('5: Gone With The Wind'), nl,
    write('6: Barbie'), nl,
    write('7: Tenet'), nl,
    write('8: The Abyss'), nl, 
    write('9: Rope'), nl,
    write('10: Superbad'), nl,
    write('11: Back to the Future'), nl,
    % Input handling starts here
    read_line_to_string(user_input, Response),
    nl,
    (   Response == "1" -> handle_specific_attribute(romance);
        Response == "2" -> handle_specific_attribute(action);
        Response == "3" -> handle_specific_attribute(drama);
        Response == "4" -> handle_specific_attribute(horror);
        Response == "5" -> handle_specific_attribute(classic);
        Response == "6" -> handle_specific_attribute(modern);
        Response == "7" -> handle_specific_attribute(nolan);
        Response == "8" -> handle_specific_attribute(cameron);
        Response == "9" -> handle_specific_attribute(hitchcock);
        Response == "10" -> handle_specific_attribute(comedy);
        Response == "11" -> handle_specific_attribute(middle);
        % Invalid input case
        write('Invalid input. Please respond with a number between 1 and 11.'), nl
    ).


% Map each movie to its attribute
movie_attribute('13 Going on 30', romance).
movie_attribute('Star Wars: A New Hope', action).
movie_attribute('A Beautiful Mind', drama).
movie_attribute('Halloween', horror).
movie_attribute('Gone With The Wind', classic).
movie_attribute('Barbie', modern).
movie_attribute('Tenet', nolan).
movie_attribute('The Abyss', cameron).
movie_attribute('Rope', hitchcock).
movie_attribute('Superbad', comedy).
movie_attribute('Back to the Future', middle).

% Function to handle ties and dynamically print movies for tied attributes
tieMenu(MostLikedAttributes) :-
    write('Pick the movie you like best from the following options:'), nl,
    % Find all movies matching the tied attributes
    findall(Movie, (movie_attribute(Movie, Attribute), member(Attribute, MostLikedAttributes)), Movies),
    % Print the movies with their indices
    print_movies(Movies, 1),
    % Read user input
    read_line_to_string(user_input, Response),
    atom_number(Response, Index),

    nth1(Index, Movies, ChosenMovie),
    movie_attribute(ChosenMovie, ChosenAttribute),
    handle_specific_attribute(ChosenAttribute).

% Helper function to print movies with their indices
print_movies([], _).
print_movies([Movie | Rest], Index) :-
    write(Index), write(': '), write(Movie), nl,
    NextIndex is Index + 1,
    print_movies(Rest, NextIndex).

% Example of handle_specific_attribute predicate
handle_specific_attribute(Attribute) :-
    write('Recommended movie based on your choice: '), nl,
    (   Attribute == romance -> write('The Notebook');
        Attribute == action -> write('Gladiator');
        Attribute == drama -> write('A Streetcar Named Desire');
        Attribute == horror -> write('Scream');
        Attribute == classic -> write('The Wizard of Oz');
        Attribute == modern -> write('Barbie');
        Attribute == nolan -> write('Interstellar');
        Attribute == cameron -> write('Aliens');
        Attribute == hitchcock -> write('Rear Window');
        Attribute == comedy -> write('Dumb and Dumber');
        Attribute == middle -> write('Apocalypse Now')
    ), nl.


% Ask the user about each movie in the list
ask_movies :-
    % Loop through each movie in the movie facts and ask about them
    findall(Movie, movie(Movie, _), Movies),  % Find all movie names
    foreach(member(Movie, Movies), ask_movie(Movie)).

% Ask the user if they like a movie
ask_movie(Movie) :-
    movie(Movie, Attributes),
    write('Do you like the movie: '), write(Movie), write('? (1 for yes/2 for no): '),
    read_line_to_string(user_input, Response),  % Use read_line_to_string to handle input
    nl,  % This consumes the newline character
    (   Response == "1" -> assert_likes_attributes(Attributes);
        Response == "2" -> true;
        write('Invalid input. Please respond with yes or no.'), nl).

% Main rule to start the program
start :-
    retractall(likes(_, _)), % Clear the likes list at the start
    ask_movies,
    handle_likes.  % Call handle_likes to process the most liked attributes

















