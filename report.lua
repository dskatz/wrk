-- example reporting script which demonstrates a custom
-- done() function that prints latency percentiles as CSV

done = function(summary, latency, requests)
   io.write("------------------------------\n")
   io.write("latency-avg,50,75,90,99,#req,duration,timeout, read, write,#status-err\n")
  -- avg, 50, 75, 90, 99, # req, duration, timeout, read, write
  io.write(string.format("%02.2f,", latency.mean/1000))

   for _, p in pairs({ 50, 75, 90, 99 }) do
      n = latency:percentile(p)
      io.write(string.format("%02.2f,", n/1000))
   end

   -- req, duration, timeout, read, write
   io.write(string.format("%d,%02.2f,%d,%d,%d,%d\n", summary.requests,(summary.duration/60000000),summary.errors.timeout, summary.errors.read, summary.errors.write, summary.errors.status))

end
