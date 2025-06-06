final List<String> photoMessages = [
  'Wow! You got Charlie!🎉',
  'Nice shot of Tatin!😊',
  'Congrats! That’s Gee!🌟',
  'Amazing! It’s Alas!💫',
  'You got a cool pic of Laurence!🥳',
  'Whoa! Look, it’s Wayne!😎',
  'Great pull — Loyd is here!✨',
  'Yay! That’s Kiel!🎈',
  'Hey, that’s Gem!💖',
  'You got Miguel — lucky!🎶',
  'Shiny card of Cray!🎸',
  'Awesome! That’s Kean!💐',
];

String getRandomMessage(int index) {
  return photoMessages[index - 1]; // index is from 1 to 12
}
