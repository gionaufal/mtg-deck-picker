# MTG Deck Picker

This is a work in progress project to find which top decks from 
[MTG Goldfish's Standard list](https://www.mtggoldfish.com/metagame/standard/full#paper)
you can build with the cards you already have.

Given a list of cards in `cards.txt`, the app compares your cards with the cards
from these top decks, and tells you which and how many cards you are lacking to
complete the deck.

### TODO:
- Encapsulate it in a CLI
- Create a web interface (probably using Phoenix)
- Publish and deploy

### How does it work

First, using the lib Floki, we scrape the MTG Goldfish 
[top decks for Standard](https://www.mtggoldfish.com/metagame/standard/full#paper),
returning in a way that a human can read. The module `Reader` reads the
`cards.txt` file and threats the data so `Mtgtopdecks` module can compare and
return a map with all the decks, sorted by which you have the most cards.

Create a file called `cards.txt` on the root folder (or remove `.sample` from
`cards.txt.sample`). Input on this file all the cards that you want to match
against the decks. The cards **must** be one per line, and in the format
`#{quantity} {card name}`:

```
2 Sanctum Seeker
4 Duress
```

If you already have your cards listed on some service like DeckBox, you can
export a file from there in this format.

##### To run
 - You'll need Elixir (tested with > 1.6).
 - In your terminal, run `mix deps.get` to install the project's dependencies.
 - Run `iex -S mix` to open the console (right now this is not a working CLI)
 - To get the decks you can build with your cards, run `decks =
   Mtgtopdecks.compare_decs`. It will return all the decks sorted by the least
cards lacking. That way, you can consult decks using, for example,
`Enum.at(decks, 0)` (this will bring you the deck that you have most cards) and
see which cards are lacking for you to build.
