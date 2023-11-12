package Events::Models::Event

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    return $self;
}

sub save {
    my $self = shift;
}

sub update {
    my $self = shift;
}

1;