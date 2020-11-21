This is Anna LaVergne's implementation of Odin's [ConnectFour project](https://www.theodinproject.com/courses/ruby-programming/lessons/testing-your-ruby-code).

The point of this project was to TDD.

After trying it, these are my thoughts on that.

* I couldn't think of any tests to write on the TwoPlayerGame class, because it's only public method is .play, which takes no input and has no output.

* On the whole, this may have been the fastest code I've written. But it also feels like the most incomplete. There are glitches that either I didn't think of when I was writing tests, or else I wasn't sure how to write tests for. 

* When I'm not trying to TDD, I do a lot of refactoring on-the-go. I start writing a method and if it gets too long, then I immediately try to reform my thinking. Because I was trying to stick with TDD, I just wrote all the methods I wanted as they first occurred to me. After I got the tests to pass and tried to refactor, I couldn't think of ways to slim my methods down. Maybe I'd still have had that problem if I wasn't TDD-ing, but it felt like a noticeable dynamic.

* When I actually played the game, I ran into glitches that the tests hadn't caught. Probably this means my tests weren't complete enough, but in some cases (like 'do these columns line up?'), writing an rspec test for it would have been prohibitively more difficult than just writing the code and trying it out.
