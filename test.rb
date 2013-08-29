nthreads = 16
iterations = 10000
threads = []

nthreads.times do |i|
  threads << Thread.new do
    iterations.times do |j|
      Note.all.map(&:name)
    end
  end
end

threads.each(&:join)

