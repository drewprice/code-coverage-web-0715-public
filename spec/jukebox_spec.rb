songs = [
  'The Phoenix - 1901',
  'Tokyo Police Club - Wait Up',
  'Sufjan Stevens - Too Much',
  'The Naked and the Famous - Young Blood',
  '(Far From) Home - Tiga',
  'The Cults - Abducted',
  'The Phoenix - Consolation Prizes'
]

describe Song do
  it 'initializes with a name' do
    song = Song.new('1901')
    expect(song.name).to eq('1901')
  end
end

describe Jukebox do

  let(:jukebox) { Jukebox.new(songs) }

  describe 'initialization' do
    it 'creates a collection of songs' do
      expect(jukebox.songs).to_not be_empty
    end

    it 'turns the jukebox on' do
      expect(jukebox.on?).to be true
    end
  end

  describe 'functionality' do
    it 'returns available commands when asked for help' do
      expect(jukebox.help).to include('help', 'list', 'play', 'exit')
    end

    it 'lists all of the available songs' do
      result = jukebox.list
      songs.each do |song|
        expect(result).to include(song)
      end
    end

    it 'plays the requested song' do
      result = jukebox.play('The Phoenix - 1901')
      expect(result).to eq('now playing The Phoenix - 1901')
    end

    it 'turns the jukebox off upon exit' do
      jb = Jukebox.new(songs)
      jb.exit
      expect(jb.on?).to be false
    end
  end

  describe 'accepting commands' do
    it 'returns an error message when an invalid command is entered' do
      result = jukebox.command('foobaz')
      expect(result).to eq('invalid command')
    end

    it 'runs each command appropriately' do
      commands = %w( list help exit )
      commands.each do |command|
        result = jukebox.command(command)
        expect(result).to eq(jukebox.send(command))
      end
    end

    it 'runs play with a user defined argument' do
      result = jukebox.command('play The Phoenix - 1901')
      expect(result).to eq(jukebox.play('The Phoenix - 1901'))
    end
  end
end
