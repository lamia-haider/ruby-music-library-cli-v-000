require 'pry'

# Upon initialization, accepts an optional path to the library of MP3 files, defaulting to ./db/mp3s/.
#It should then instantiate a MusicImporter object,
#which it will use to import songs from the specified library.

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = ""
    while input != "exit"
      input = gets.strip
    end
  end

  def list_songs
    Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort{|a, b| a.name <=> b.name}.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
  end

  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name}.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    inp = gets.strip
    if artist = Artist.find_by_name(inp)
      artist.songs.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |c, i|
        puts "#{i}. #{c.name} - #{c.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort{ |a,b| a.name <=> b.name}.each.with_index(1) do |g, i|
        puts "#{i}. #{g.artist.name} - #{g.name}"
      end
    end
  end

  def play_song
      puts "Which song number would you like to play?"
      input = gets.strip.to_i
      Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |song, i|
        if i-1 == input
          puts "Playing #{song.name} by #{song.artist.name}"
        end
      end

  end
end