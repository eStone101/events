package Events::Repositories::EventRepository;

use strict;
use warnings;

use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    return $self;
}

sub all {
    my $self = shift;
    my $table = 'events';


}

sub find {
    my $self = shift;
    my $id = shift;
}

sub get {
    my $self = shift;
    my $params = shift;

}

sub getUpcomingEvents {
    my $self = shift;

    my $table = 'events';

    my $sql = sprintf('SELECT * FROM %s WHERE date > CURRENT_TIMESTAMP()', $table);
    my $dbh = &_::app()->database();
    my $sth = $dbh->prepare($sql);
    $sth->execute();

    my @upcomingEvents;
    while (my $row = $sth->fetchrow_hashref()) {
        push(@upcomingEvents, $row);
    }

    return \@upcomingEvents;
}

sub newModel {

    return Events::Models::Event->new(@_);
}

1;