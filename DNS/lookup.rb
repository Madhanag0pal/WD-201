def get_command_line_argument
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

domain = get_command_line_argument

dns_raw = File.readlines("zone")

def parse_dns(dns)
  dns.reject { |line| line[0] == "#" }.
    map { |line| line.split(",").map(&:strip) }.
    reject { |record| record.length < 3 }.
    each_with_object({}) do |record, records|
    records[record[1]] = {
      type: record[0],
      target: record[2],
    }
  end
end

def resolve(dns_records, lookup_chain, domain)
  record = dns_records[domain]
  if (!record)
    return lookup_chain = ["Error: Record not found for " + domain]
  elsif record[:type] == "CNAME"
    lookup_chain << record[:target]
    return resolve(dns_records, lookup_chain, record[:target])
  elsif record[:type] == "A"
    return lookup_chain << record[:target]
  else
    return lookup_chain << "Invalid record type for " + domain
  end
end

dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)

puts lookup_chain * " => "
