package Events::Actions::CreateEvent;

use strict;
use warnings;

use Foundation::Appify;
use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    return $self;
}

sub handle {
    my $self = shift;
    my $request = shift;

    my $table = 'events';

    my $sql = sprintf(
        "INSERT INTO %s (date, type, location) VALUES (?, ?, ?)",
        $table,
    );

    my $dbh = &_::app()->database();
    my $sth = $dbh->prepare($sql);
    $sth->execute(
        $request->param('date'),
        $request->param('type'),
        $request->param('location')
    ) or die $sth->errstr;
}

1;