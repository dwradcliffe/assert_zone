require 'assert_zone/version'
require 'dns/zone'
require 'rspec'
require 'rspec-dns'

module AssertZone
  def self.run(filename, nameserver: nil, rspec_flags: [], use_local_resolver: false, skip_soa: false, skip_ns: false)
    ns_config = {}
    ns_config[:nameserver] = nameserver if nameserver

    zone = DNS::Zone.load(File.read(filename))

    unless use_local_resolver
      # default to nameserver from SOA in zone
      ns_config[:nameserver] ||= zone.soa.nameserver
      # output the custom nameserver
      puts "Using nameserver: #{ns_config[:nameserver]}"
    end

    zone.records.each do |record|
      next if record.is_a?(DNS::Zone::RR::SOA) if skip_soa
      next if record.is_a?(DNS::Zone::RR::NS) if skip_ns

      fqdn = record.label == '@' ? zone.origin : "#{record.label}.#{zone.origin}".chomp('.')

      describe fqdn do
        if record.is_a?(DNS::Zone::RR::A)
          it { is_expected.to have_dns.with_type(record.type).config(ns_config).and_ttl(record.ttl).and_address(record.address) }
        elsif record.is_a?(DNS::Zone::RR::CNAME)
          it { is_expected.to have_dns.with_type(record.type).config(ns_config).and_ttl(record.ttl).and_domainname(record.domainname.chomp('.')) }
        elsif record.is_a?(DNS::Zone::RR::TXT)
          it { is_expected.to have_dns.with_type(record.type).config(ns_config).and_ttl(record.ttl).and_data(record.text) }
        else
          it { is_expected.to have_dns.with_type(record.type).config(ns_config).and_ttl(record.ttl) }
          warn "WARN: Unsupported record type: #{record.type}. Value of record for #{fqdn} will not be tested."
        end
      end
    end

    RSpec::Core::Runner.run(rspec_flags)

  end
end
